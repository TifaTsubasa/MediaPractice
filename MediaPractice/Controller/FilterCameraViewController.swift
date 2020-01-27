//
//  FilterCameraViewController.swift
//  MediaPractice
//
//  Created by tsuf on 2020/1/27.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import GPUImage
import AVFoundation

class FilterCameraViewController: UIViewController {
  
  private weak var previewView: RenderView!
  private weak var camera: Camera!
  private var filter = SketchFilter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let previewView = RenderView()
    self.previewView = previewView
    previewView.contentMode = .scaleAspectFill
    previewView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 400)
    view.addSubview(previewView)
    
    guard let camera = try? Camera(sessionPreset: AVCaptureSession.Preset.hd1920x1080) else {
      fatalError("initialize camera error")
    }
    self.camera = camera
    
    camera --> filter --> previewView
    camera.startCapture()
   
    let stackView = UIStackView()
    stackView.distribution = .equalSpacing
    stackView.spacing = 10
    view.addSubview(stackView)
    stackView.frame = CGRect(x: 100, y: view.bounds.height - 80,
                             width: view.bounds.width - 200 - 10, height: 60)
    
    let takeBtn = UIButton()
    takeBtn.setTitle("拍照", for: .normal)
    stackView.addArrangedSubview(takeBtn)
    takeBtn.addTarget(self, action: #selector(onTakePhone), for: .touchUpInside)
  }
  
  @objc private func onTakePhone() {
    let pictureOutput = PictureOutput()
    pictureOutput.encodedImageFormat = .jpeg
    pictureOutput.imageAvailableCallback = { image in
      UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    self.camera --> filter --> pictureOutput
    let path = "\(NSHomeDirectory())phone.jpeg"
    pictureOutput.saveNextFrameToURL(URL(fileURLWithPath: path), format: PictureFileFormat.jpeg)
  }

}
