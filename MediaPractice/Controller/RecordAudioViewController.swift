//
//  ViewController.swift
//  MediaPractice
//
//  Created by upmer on 2020/1/15.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController {
    
    private let recorder = AudioRecorder()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(AVAudioSession.sharedInstance().availableCategories)
    }

    @IBAction func startRecord(_ sender: Any) {
        recorder.start()
    }
    @IBAction func stopRecord(_ sender: Any) {
        recorder.stop()
    }
    
}

