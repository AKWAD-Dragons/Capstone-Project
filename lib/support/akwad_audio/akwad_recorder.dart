library akwad_recorder;

import 'dart:async';
import 'dart:io';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart';

class AkwadRecorder {
  Directory _audioDir;
  Recording _currentRecording;
  File _convertedMp3File;
  FlutterAudioRecorder _recorder;
  PublishSubject<RecordingState> recordingSubject = PublishSubject();
  static const platform = const MethodChannel('flutter/mp3');

  Timer _recordingTimer;

  AkwadRecorder({String relativePath}) {
    if (relativePath == null) {
      PackageInfo.fromPlatform().then((PackageInfo pk) {
        _setupAppAudioDirectory(pk.appName);
      });
    } else {
      _setupAppAudioDirectory(relativePath);
    }
  }

  Future<Directory> _setupAppAudioDirectory(String relativePath) async {
    if (!relativePath.startsWith("/")) {
      relativePath = "/" + relativePath;
    }

    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    Directory dir = await Directory(appDocDirectory.path + relativePath)
        .create(recursive: true);
    if (dir == null) throw "Can't Create Path";

    _audioDir = dir;
    print(dir);
    return dir;
  }

  Future<String> _checkPermissions() async {
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions(
        [PermissionGroup.microphone, PermissionGroup.storage]);

    if (permissions[PermissionGroup.microphone] != PermissionStatus.granted) {
      return "mic";
    }
    if (permissions[PermissionGroup.storage] != PermissionStatus.granted &&
        !Platform.isIOS) {
      return "storage";
    }
    return "granted";
  }

  bool _canRecord() {
    if (_currentRecording == null) return true;
    if (_currentRecording.status == RecordingStatus.Unset ||
        _currentRecording.status == RecordingStatus.Recording ||
        _currentRecording.status == RecordingStatus.Paused) {
      return false;
    }

    return true;
  }

  Future<Recording> start({String fileName,
    AudioFormat audioFormat = AudioFormat.AAC,
    int sampleRate = 16000}) async {
    if (!_canRecord()) {
      return null;
    }
    recordingSubject.sink
        .add(RecordingState._(_currentRecording, RecStates.BLOCKED));
    String checkPermission = await _checkPermissions();
    if (checkPermission != "granted") {
      print("ERROR::$checkPermission is not granted");
      recordingSubject.sink
          .add(RecordingState._(_currentRecording, RecStates.IDLE));
      return null;
    }
    if (fileName == null) {
      fileName = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
    }

    fileName = _audioDir.path + "/" + fileName;

    _recorder = FlutterAudioRecorder(fileName,
        audioFormat: audioFormat, sampleRate: sampleRate);

    await _recorder.initialized;
    await _recorder.start();
    _currentRecording = await _recorder.current();
    _setIsRecording();
    return _currentRecording;
  }

  Future resume() async {
    await _recorder.resume();
    _setIsRecording();
  }

  Future pause() async {
    if (_currentRecording.status != RecordingStatus.Recording) {
      return null;
    }
    await _recorder.pause();
    _setNotRecording();
    recordingSubject.add(RecordingState._(_currentRecording, RecStates.PAUSED));
  }

  Future<void> stop() async {
    if (_currentRecording == null) return;
    if (_currentRecording.status != RecordingStatus.Recording &&
        _currentRecording.status != RecordingStatus.Paused) {
      return;
    }
    if (_recorder == null) return;
    await _recorder.stop();
    _setNotRecording();
    await _convertAudioFileNatively(_currentRecording.path);
    _currentRecording.path = _convertedMp3File.path;
    recordingSubject
        .add(RecordingState._(_currentRecording, RecStates.STOPPED));
  }

  /// Converts the finished [_currentRecording] to an MP3 file using
  /// [FFMPEG] encoders in [Android] & [iOS] native modules due to
  /// [FFMPEG] huge package size in [Flutter]


  Future<void> _convertAudioFileNatively(String path) async {
    try {
      final _mp3FilePath = await platform
          .invokeMethod('convertToMp3', {'recording': path}) as String;
      print('^^^^^^^^^^^^^^$_mp3FilePath^^^^^^^^^^^^^^^^');
      if (_mp3FilePath != null) {
        print("Done");
        _convertedMp3File = File(_mp3FilePath);
      } else {
        throw 'UNSUPPORTED RECORDING FORMAT';
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  void _setIsRecording() {
    _recordingTimer = Timer.periodic(Duration(milliseconds: 500), (_) async {
      _currentRecording = await _recorder.current();
      recordingSubject.sink
          .add(RecordingState._(_currentRecording, RecStates.RECORDING));
    });
  }

  void _setNotRecording() {
    if (_recordingTimer == null) {
      return;
    }
    _recordingTimer.cancel();
  }
}

enum RecStates { IDLE, BLOCKED, RECORDING, PAUSED, STOPPED }

class RecordingState {
  Recording recording;
  RecStates recState;

  RecordingState._(this.recording, this.recState);
}
