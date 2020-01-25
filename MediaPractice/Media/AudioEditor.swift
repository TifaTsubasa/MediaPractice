//
//  AudioEditor.swift
//  MediaPractice
//
//  Created by tsuf on 2020/1/25.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import AVFoundation

class AudioEditor: NSObject {

  func crop(asset: AVURLAsset, from startTime: CMTime, to endTime: CMTime, completion: @escaping ((URL?, Error?) -> Void)) {
    
    let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A)
    
    let outputPath = "\(NSTemporaryDirectory())cut.m4a"
    let outputURL = URL(fileURLWithPath: outputPath)
    if FileManager.default.fileExists(atPath: outputPath) {
      try? FileManager.default.removeItem(at: outputURL)
    }
    
    
    exportSession?.outputURL = outputURL
    exportSession?.outputFileType = AVFileType.m4a
    exportSession?.timeRange = CMTimeRange(start: startTime, duration: endTime - startTime)
    
    exportSession?.exportAsynchronously(completionHandler: {
      if exportSession?.status == AVAssetExportSession.Status.completed {
        completion(outputURL, nil)
      } else {
        completion(nil, exportSession?.error)
      }
    })
//    NSString *outPutPath = [[self composeDir] stringByAppendingPathComponent:@"Crop.m4a"];
//    NSURL *audioFileOutput = [NSURL fileURLWithPath:outPutPath];
//
//    [[NSFileManager defaultManager] removeItemAtURL:audioFileOutput error:NULL];
//    AVAsset *asset = [AVAsset assetWithURL:url];
//
//    AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:asset
//                                                                            presetName:AVAssetExportPresetAppleM4A];
//    CMTimeRange exportTimeRange = CMTimeRangeFromTimeToTime(startTime, endTime);
//
//    exportSession.outputURL = audioFileOutput;
//    exportSession.outputFileType = AVFileTypeAppleM4A;
//    exportSession.timeRange = exportTimeRange;
//
//    [exportSession exportAsynchronouslyWithCompletionHandler:^{
//        if (AVAssetExportSessionStatusCompleted == exportSession.status) {
//            NSLog(@" FlyElephant \n %@", outPutPath);
//        } else if (AVAssetExportSessionStatusFailed == exportSession.status) {
//            NSLog(@"FlyElephant error: %@", exportSession.error.localizedDescription);
//        }
//    }];
  }
}
