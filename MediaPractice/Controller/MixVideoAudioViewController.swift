//
//  MixVideoAudioViewController.swift
//  MediaPractice
//
//  Created by tsuf on 2020/1/29.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import AVFoundation

class MixVideoAudioViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let videoPath = Bundle.main.url(forResource: "1", withExtension: "MP4"),
      let audioPath = Bundle.main.url(forResource: "1", withExtension: "mp3") else {
        return
    }
    let videoAsset = AVURLAsset(url: videoPath)
    let audioAsset = AVURLAsset(url: audioPath)
    VideoMixer.mix(video: videoAsset, audio: audioAsset) { (res) in
      switch res {
        case let .success(url):
        print(url)
        case let .failure(error):
        print(error)
      }
    }
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
