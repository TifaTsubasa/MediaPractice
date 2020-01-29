//
//  VideoMixer.swift
//  MediaPractice
//
//  Created by tsuf on 2020/1/25.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import AVFoundation

class VideoMixer {
  static func mix(video: AVURLAsset, audio: AVURLAsset, completion: @escaping ((Result<URL, Error>) -> Void)) {
    let mixComposition = AVMutableComposition()
    let videoTrack = mixComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)
    let audioTrack = mixComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)
    
    let videoRange = CMTimeRange(start: CMTime.zero, duration: video.duration)
    let audioRange = CMTimeRange(start: CMTime.zero, duration: audio.duration)
    
    do {
      try videoTrack?.insertTimeRange(videoRange, of: video.tracks(withMediaType: AVMediaType.video)[0], at: CMTime.zero)
      try audioTrack?.insertTimeRange(audioRange, of: audio.tracks[0], at: CMTime.zero)
    } catch {
      fatalError(error.localizedDescription)
    }
    
    
    let path = "\(NSTemporaryDirectory())video_audi_mix.mp4"
    let url = URL(fileURLWithPath: path)
    if FileManager.default.fileExists(atPath: path) {
      try? FileManager.default.removeItem(at: url)
    }
    
    let exportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)
    exportSession?.outputURL = url
    exportSession?.outputFileType = AVFileType.mov
    exportSession?.shouldOptimizeForNetworkUse = true
    exportSession?.exportAsynchronously {
      if exportSession?.status == AVAssetExportSession.Status.completed {
        completion(Result.success(url))
      } else {
        completion(Result.failure(exportSession!.error!))
      }
    }
//
//    //视频文件资源
//
//    // presetName 与 outputFileType 要对应  导出合并的音频
//    AVAssetExportSession* assetExportSession = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetMediumQuality];
//    assetExportSession.outputURL = destUrl;
//    assetExportSession.outputFileType = @"com.apple.quicktime-movie";
//    assetExportSession.shouldOptimizeForNetworkUse = YES;
//    [assetExportSession exportAsynchronouslyWithCompletionHandler:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"%@",assetExportSession.error);
//        });
//    }];
  }
}
