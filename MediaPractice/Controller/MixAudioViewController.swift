//
//  MixAudioViewController.swift
//  MediaPractice
//
//  Created by tsuf on 2020/1/26.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import AVFoundation

class MixAudioViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let url1 = Bundle.main.url(forResource: "1", withExtension: "aac"),
      let url2 = Bundle.main.url(forResource: "2", withExtension: "aac") else {
      return
    }
    let asset1 = AVURLAsset(url: url1)
    let asset2 = AVURLAsset(url: url2)
    let component1 = MixAudioComponent(asset: asset1, timeRange: CMTimeRange(start: CMTime.zero, duration: CMTime(value: 90, timescale: 30)))
    
    let component2 = MixAudioComponent(asset: asset2, timeRange: CMTimeRange(start: CMTime(value: 90, timescale: 30), duration: CMTime(value: 90, timescale: 30)))
    AudioMixer.mix(components: [component1, component2]) { (res) in
      switch res {
      case let .success(url):
        print(url)
      case let .failure(error):
        print(error)
      }
    }
    // Do any additional setup after loading the view.
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
