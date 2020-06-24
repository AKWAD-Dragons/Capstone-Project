///////////////////////////////////////////////////////////////////////////////
///                                                                         ///
///          THIS FILE IS NO LONGER USABLE DUE TO FATAL ISSUES              ///
///       PLEASE DO NOT IMPORT ANY OF ITS CLASSES AS LONG AS THIS           ///
///                         COMMENT IS HERE                                 ///
///                                                                         ///
///////////////////////////////////////////////////////////////////////////////

library akwad_playback;

import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

class AkwadPlayback {
  static Directory _audioDir;
  static AudioPlayer _audioPlayer;
  static int _currentDuration = 0;
  static int _currentPosition = 0;
  static PublishSubject<PlaybackState> playbackStateSubject = PublishSubject();

  static Timer _playbackTimer;
  static String taskID;
  static String fileLocalPath;

  AkwadPlayback({String relativePath}) {
    _audioPlayer = AudioPlayer();
    if (relativePath == null) {
      PackageInfo packageInfo;
      PackageInfo.fromPlatform().then((PackageInfo pk) {
        packageInfo = pk;
        setupAppAudioDirectory(pk.appName);
      });
    } else {
      setupAppAudioDirectory(relativePath);
    }
  }

  Future<Directory> setupAppAudioDirectory(String relativePath) async {
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

  static Future<String> checkPermissions() async {
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions(
        [PermissionGroup.microphone, PermissionGroup.storage]);
    if (permissions[PermissionGroup.storage] != PermissionStatus.granted &&
        !Platform.isIOS) {
      return "storage";
    }
    return "granted";
  }

  static Future<void> play(String fileURL) async {
    String response = await checkPermissions();
    _audioPlayer = AudioPlayer();
    if (response != "granted") {
      print(response);
      return;
    }
    if (_audioPlayer != null &&
        _audioPlayer.state == AudioPlayerState.PLAYING) {
      return;
    }

    playbackStateSubject.sink
        .add(PlaybackState._(PlaybackStates.BLOCKED, 0, 0));

    fileLocalPath =
    "${_audioDir.path}${fileURL.substring(fileURL.lastIndexOf("/"), fileURL.length)}";

    bool fileAlreadyExists = FileSystemEntity.typeSync(fileLocalPath) !=
        FileSystemEntityType.notFound;

    if (fileAlreadyExists == false) {
      playbackStateSubject.sink
          .add(PlaybackState._(PlaybackStates.DOWNLOADING, 0, 0));
      taskID = await FlutterDownloader.enqueue(
          url: fileURL, savedDir: _audioDir.path, showNotification: false);

      FlutterDownloader.registerCallback(downloadCallBack);
    }else{
      _playLocal();
    }
  }

  static Future<void> downloadCallBack(String id, DownloadTaskStatus status, int progress) async {
    if (status.value == DownloadTaskStatus.complete.value) {
      play(fileLocalPath);
      print('AUDIO CLIP DOWNLOAD COMPLETED');
    }else if(status.value == DownloadTaskStatus.failed.value){
      Future.delayed(Duration(seconds: 3));
      play(fileLocalPath);
      print('AUDIO CLIP DOWNLOAD FAILED');
    }else{
      Future.delayed(Duration(seconds: 3));
      play(fileLocalPath);
      print(status.value);
      print('AUDIO CLIP DOWNLOAD UNDEFIENED');
    }
  }

  static Future<void> _playLocal() async {
    int works = await _audioPlayer.play(fileLocalPath,
        isLocal: true);

    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState status) {
      if (status == AudioPlayerState.COMPLETED) {
        stop();
      }
    });

    if (works != 1) {
      print("PLAY DIDN'T WORK");
      return;
    }

    _startTimer();

    playbackStateSubject.sink.add(
        PlaybackState._(PlaybackStates.PLAYING, _currentDuration, 0));
  }

  static Future<void> stop() async {
    if (_audioPlayer.state == AudioPlayerState.STOPPED) return;

    playbackStateSubject.sink
        .add(PlaybackState._(PlaybackStates.BLOCKED, 0, 0));

    await _audioPlayer.stop();
    _stopTimer();

    playbackStateSubject.sink.add(PlaybackState._(PlaybackStates.IDLE, 0, 0));
  }

  static Future<void> pause() async {
    if (_audioPlayer.state == AudioPlayerState.PAUSED) return;

    playbackStateSubject.sink.add(PlaybackState._(
        PlaybackStates.BLOCKED, _currentDuration, _currentPosition));
    _stopTimer();

    await _audioPlayer.pause();

    playbackStateSubject.sink.add(PlaybackState._(
        PlaybackStates.PAUSED, _currentDuration, _currentPosition));
  }

  static Future<void> resume() async {
    if (_audioPlayer.state == AudioPlayerState.PLAYING) return;
    playbackStateSubject.sink.add(PlaybackState._(
        PlaybackStates.BLOCKED, _currentDuration, _currentPosition));
    await _audioPlayer.resume();
    playbackStateSubject.sink
        .add(PlaybackState._(PlaybackStates.PLAYING, _currentDuration, 0));
    _startTimer();
  }

  static _startTimer() {
    try {
      _playbackTimer =
          Timer.periodic(Duration(milliseconds: 500), (Timer timer) async {
            if(_audioPlayer.state != AudioPlayerState.PLAYING) return;
            int position = await _audioPlayer.getCurrentPosition();
            int duration = await _audioPlayer.getDuration();
            _currentPosition = position;
            _currentDuration = duration;
            playbackStateSubject.sink
                .add(
                PlaybackState._(PlaybackStates.PLAYING, duration, position));
          });
    }catch(e){
      print(e);
    }
  }

  static _stopTimer() {
    if(_playbackTimer==null) return;
    _playbackTimer.cancel();
    _playbackTimer = null;
  }
}

enum PlaybackStates { IDLE, DOWNLOADING, BLOCKED, PLAYING, PAUSED }

class PlaybackState {
  PlaybackStates playbackStates;
  int duration;
  int currentPosition;

  PlaybackState._(this.playbackStates, this.duration, this.currentPosition);
}
