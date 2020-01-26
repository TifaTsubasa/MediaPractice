//
//  AudioMixer.swift
//  MediaPractice
//
//  Created by tsuf on 2020/1/25.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import AVFoundation

struct MixAudioComponent {
  var asset: AVURLAsset
  var timeRange: CMTimeRange
}

class AudioMixer {
  
//  static let path = ""
  
  static func mix(components: [MixAudioComponent], completion: @escaping ((Result<URL, Error>) -> Void)) {
    let outputPath = "\(NSTemporaryDirectory())mix_audio.m4a"
    let outputURL = URL(fileURLWithPath: outputPath)
    if FileManager.default.fileExists(atPath: outputPath) {
      try? FileManager.default.removeItem(at: outputURL)
    }
    
    let composition = AVMutableComposition()
    guard let track = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid) else {
      fatalError("track setup error")
    }
    var beginTime = CMTime.zero
    for component in components {
      do {
        try track.insertTimeRange(component.timeRange, of: component.asset.tracks[0], at: beginTime)
        beginTime = CMTimeAdd(beginTime, component.timeRange.duration)
      } catch {
        print("insert error: \(error)")
      }
      
    }
    
    guard let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A) else {
      fatalError("session setup error")
    }
    exportSession.outputURL = outputURL
    exportSession.outputFileType = AVFileType.m4a
    exportSession.shouldOptimizeForNetworkUse = true
    exportSession.exportAsynchronously {
      if exportSession.status == AVAssetExportSession.Status.completed {
        completion(Result.success(outputURL))
      } else {
        completion(Result.failure(exportSession.error!))
      }
    }
    
//    let exportSession = AVAssetExportSession(asset: <#T##AVAsset#>, presetName: <#T##String#>)
//
//    for (NSURL *sourceURL in dataSource) {
//        //音频文件资源
//        AVURLAsset  *audioAsset = [[AVURLAsset alloc] initWithURL:sourceURL options:nil];
//        //需要合并的音频文件的区间
//        CMTimeRange audio_timeRange = CMTimeRangeMake(kCMTimeZero, audioAsset.duration);
//        // ofTrack 音频文件内容
//        BOOL success = [compositionAudioTrack insertTimeRange:audio_timeRange ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] firstObject] atTime:beginTime error:&error];
//    }
//    // presetName 与 outputFileType 要对应  导出合并的音频
//    AVAssetExportSession *assetExportSession = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetAppleM4A];
//    assetExportSession.outputURL = destUrl;
//    assetExportSession.outputFileType = @"com.apple.m4a-audio";
//    assetExportSession.shouldOptimizeForNetworkUse = YES;
//    [assetExportSession exportAsynchronouslyWithCompletionHandler:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"%@",assetExportSession.error);
//        });
//    }];
  }
}
