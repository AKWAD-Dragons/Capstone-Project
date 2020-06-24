import UIKit
import Flutter
import flutter_downloader
import AudioToolbox
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAgallKoHzA0_J6xyQZYVmKGu1OHStf_Pc")
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "flutter/mp3",
                                              binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
      guard call.method == "convertToMp3" else {
        result(FlutterMethodNotImplemented)
        return
      }
      guard let args = call.arguments else {
        return
      }
      if let myArgs = args as? [String: Any],
        let path = myArgs["recording"] as? String
        
    {
        let dest = path.replacingOccurrences(of: "m4a", with: "mp3")
        let fileUrl = URL(string: path)
        let destUrl = URL(string: dest)
        (self?.convertToMp3(fileUrl!,result: result,outputURL:destUrl!))!

      } else {
        result("iOS could not extract flutter arguments in method: (sendParams)")
      } 


    })

    GeneratedPluginRegistrant.register(with: self)
    FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func convertToMp3(_ url: URL,result: FlutterResult, outputURL: URL){
    var error : OSStatus = noErr
    var destinationFile: ExtAudioFileRef? = nil
    var sourceFile : ExtAudioFileRef? = nil
    //var outputURL:URL
    var srcFormat : AudioStreamBasicDescription = AudioStreamBasicDescription()
    var dstFormat : AudioStreamBasicDescription = AudioStreamBasicDescription()

    ExtAudioFileOpenURL(url as CFURL, &sourceFile)

    var thePropertySize: UInt32 = UInt32(MemoryLayout.stride(ofValue: srcFormat))

    ExtAudioFileGetProperty(sourceFile!,
                            kExtAudioFileProperty_FileDataFormat,
                            &thePropertySize, &srcFormat)

    dstFormat.mSampleRate = 44100  //Set sample rate
    dstFormat.mFormatID = kAudioFormatLinearPCM
    dstFormat.mChannelsPerFrame = 1
    dstFormat.mBitsPerChannel = 16
    dstFormat.mBytesPerPacket = 2 * dstFormat.mChannelsPerFrame
    dstFormat.mBytesPerFrame = 2 * dstFormat.mChannelsPerFrame
    dstFormat.mFramesPerPacket = 1
    dstFormat.mFormatFlags = kLinearPCMFormatFlagIsPacked |
    kAudioFormatFlagIsSignedInteger

    // Create destination file
    error = ExtAudioFileCreateWithURL(
        outputURL as CFURL,
        kAudioFileWAVEType,
        &dstFormat,
        nil,
        AudioFileFlags.eraseFile.rawValue,
        &destinationFile)
    print("Error 1 in convertAudio: \(error.description)")

    error = ExtAudioFileSetProperty(sourceFile!,
                                    kExtAudioFileProperty_ClientDataFormat,
                                    thePropertySize,
                                    &dstFormat)
    print("Error 2 in convertAudio: \(error.description)")

    error = ExtAudioFileSetProperty(destinationFile!,
                                    kExtAudioFileProperty_ClientDataFormat,
                                    thePropertySize,
                                    &dstFormat)
    print("Error 3 in convertAudio: \(error.description)")

    let bufferByteSize : UInt32 = 32768
    var srcBuffer = [UInt8](repeating: 0, count: 32768)
    var sourceFrameOffset : ULONG = 0

    while(true){
        var fillBufList = AudioBufferList(
            mNumberBuffers: 1,
            mBuffers: AudioBuffer(
                mNumberChannels: 2,
                mDataByteSize: UInt32(srcBuffer.count),
                mData: &srcBuffer
            )
        )
        var numFrames : UInt32 = 0

        if(dstFormat.mBytesPerFrame > 0){
            numFrames = bufferByteSize / dstFormat.mBytesPerFrame
        }

        error = ExtAudioFileRead(sourceFile!, &numFrames, &fillBufList)
        print("Error 4 in convertAudio: \(error.description)")

        if(numFrames == 0){
            error = noErr;
            break;
        }

        sourceFrameOffset += numFrames
        error = ExtAudioFileWrite(destinationFile!, numFrames, &fillBufList)
        print("Error 5 in convertAudio: \(error.description)")
    }

    error = ExtAudioFileDispose(destinationFile!)
    print("Error 6 in convertAudio: \(error.description)")
    error = ExtAudioFileDispose(sourceFile!)
    print("Error 7 in convertAudio: \(error.description)")
    print("The string is \(outputURL.absoluteString)")
    result(outputURL.absoluteString)
}
}

private func registerPlugins(registry: FlutterPluginRegistry) {
    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
       FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin"))
    }
}
