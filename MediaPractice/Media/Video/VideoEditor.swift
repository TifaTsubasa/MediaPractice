//
//  VideoEditor.swift
//  MediaPractice
//
//  Created by tsuf on 2020/1/30.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import AVFoundation
import GPUImage

class VideoEditor {
  
  
  static func filter(video: AVURLAsset) {
    let videoTrack = video.tracks(withMediaType: .video)[0]
    
    let input = try! MovieInput(asset: video, playAtActualSpeed: true, loop: true)
    
    let filter = LookupFilter()
    filter.lookupImage = PictureInput(image:UIImage(named:"lut_abao.png")!)

    let path = "\(NSTemporaryDirectory())filter_video.mov"
    let url = URL(fileURLWithPath: path)
    if FileManager.default.fileExists(atPath: path) {
      try? FileManager.default.removeItem(at: url)
    }
    
    let s = Size(width: Float(videoTrack.naturalSize.width),
                 height: Float(videoTrack.naturalSize.height))
    let output = try! MovieOutput(URL: url, size: s, fileType: .mov, liveVideo: true)
    
    input --> filter --> output
    output.activateAudioTrack()
    output.startRecording()
    input.start()
    output.finishRecording {
      print("finish")
    }
  }

}
