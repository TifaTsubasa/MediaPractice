//
//  AudioRecorder.swift
//  MediaPractice
//
//  Created by upmer on 2020/1/15.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import AVFoundation

class AudioRecorder: NSObject {
  
  private var recorder: AVAudioRecorder!
  
  private weak var timer: Timer?
  
  override init() {
    
    super.init()
    test()
  }
  
  private func test() {
    
    let recordSetting: [String: Any] = [
      AVFormatIDKey: kAudioFormatMPEG4AAC,
      AVSampleRateKey: 44100,
      AVNumberOfChannelsKey: 1,
      AVEncoderBitDepthHintKey: 16,
      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    
    let path = "\(NSHomeDirectory())/tmp/tmp.aac"
    let url = URL(fileURLWithPath: path)
    
    do {
      self.recorder = try AVAudioRecorder(url: url, settings: recordSetting)
      self.recorder.isMeteringEnabled = true
      self.recorder.delegate = self
      let audioSession = AVAudioSession.sharedInstance()
      try audioSession.setActive(true)
      if recorder.prepareToRecord() {
        print("prepare record success")
      } else {
        print("prepare record failed")
      }
      try audioSession.setCategory(AVAudioSession.Category.record)
    } catch {
      fatalError("initialize recorder error: \(error)")
    }
  }
  
  func start() {
    if self.recorder.record() {
      print("start record")
      let timer = Timer(timeInterval: 0.5, repeats: true) { [unowned self] (_) in
        self.recorder.updateMeters()
        let power = self.recorder.peakPower(forChannel: 0)
        print("power: \(power)")
      }
      RunLoop.current.add(timer, forMode: .default)
      self.timer = timer
    } else {
      print("start failed")
    }
    
  }
  
  func stop() {
    self.recorder.stop()
  }
  
  private func startTimer() {
    
  }
  
  deinit {
    self.timer?.invalidate()
  }
}

extension AudioRecorder: AVAudioRecorderDelegate {
  func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
    print("audioRecorderEncodeErrorDidOccur: \(error)")
  }
  
  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    
  }
}
