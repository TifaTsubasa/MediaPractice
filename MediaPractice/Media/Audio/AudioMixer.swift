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
  }
}
