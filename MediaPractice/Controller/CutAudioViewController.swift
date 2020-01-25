//
//  CutAudioViewController.swift
//  MediaPractice
//
//  Created by tsuf on 2020/1/25.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import AVFoundation

class CutAudioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      if let url = Bundle.main.url(forResource: "1", withExtension: "aac") {
        let asset = AVURLAsset(url: url)
        AudioEditor().crop(asset: asset, from: CMTime.zero, to: CMTime(value: 90, timescale: 30)) { (outputURL, error) in
          if let outputURL = outputURL {
            print(outputURL)
          } else {
            print(error)
          }
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
