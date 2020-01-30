//
//  RecordVideoViewController.swift
//  MediaPractice
//
//  Created by tsuf on 2020/1/30.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import AVFoundation
import GPUImage

class RecordVideoViewController: UIViewController {
  
  let path = "\(NSTemporaryDirectory())record_video.mov"
  
  private weak var previewView: RenderView!
  private weak var camera: Camera!
  private var filter: LookupFilter!
  private var movieOutput: MovieOutput!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    
    let previewView = RenderView()
    self.previewView = previewView
    previewView.contentMode = .scaleAspectFill
    let width = view.bounds.width
    previewView.frame = CGRect(x: 0, y: 100, width: width, height: width / 1920 * 1080)
    view.addSubview(previewView)
    
    let url = URL(fileURLWithPath: path)
    movieOutput = try! MovieOutput(URL: url, size: Size(width: 1920, height: 1080),
                                   fileType: AVFileType.mov, liveVideo: true)
    
    let filter = LookupFilter()
    filter.lookupImage = PictureInput(image:UIImage(named:"lut_abao.png")!)
    self.filter = filter
    
    guard let camera = try? Camera(sessionPreset: AVCaptureSession.Preset.hd1920x1080, orientation: nil) else {
      fatalError("initialize camera error")
    }
    self.camera = camera
    
    camera --> filter --> previewView
    
    filter --> movieOutput
    camera.startCapture()
    
    let stackView = UIStackView()
    stackView.distribution = .equalSpacing
    stackView.spacing = 10
    view.addSubview(stackView)
    stackView.frame = CGRect(x: 100, y: view.bounds.height - 80,
                             width: view.bounds.width - 200 - 10, height: 60)
    
    let startBtn = UIButton()
    startBtn.setTitle("开始", for: .normal)
    startBtn.setTitleColor(.black, for: .normal)
    stackView.addArrangedSubview(startBtn)
    startBtn.addTarget(self, action: #selector(onStartRecord), for: .touchUpInside)
    
    let stopBtn = UIButton()
    stopBtn.setTitle("停止", for: .normal)
    stopBtn.setTitleColor(.black, for: .normal)
    stackView.addArrangedSubview(stopBtn)
    stopBtn.addTarget(self, action: #selector(onStopRecord), for: .touchUpInside)
  }
  
  @objc private func onStartRecord() {
    if FileManager.default.fileExists(atPath: path) {
      try? FileManager.default.removeItem(at: URL(fileURLWithPath: path))
    }
    movieOutput.activateAudioTrack()
    movieOutput.startRecording()
  }
  
  @objc private func onStopRecord() {
    movieOutput.finishRecording() {
      let asset = AVURLAsset(url: URL(fileURLWithPath: self.path))
      print(asset.duration, asset.tracks)
      UISaveVideoAtPathToSavedPhotosAlbum(self.path, nil, nil, nil)
    }
  }
}
