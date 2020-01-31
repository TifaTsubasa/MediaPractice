//
//  FilterVideoViewController.swift
//  MediaPractice
//
//  Created by tsuf on 2020/1/30.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import AVFoundation
import GPUImage

class FilterVideoViewController: UIViewController {
  
  let path = "\(NSTemporaryDirectory())filter_video.mov"
  
  private weak var previewView: RenderView!
  private var movie: MovieInput!
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
    
    let movieURL = Bundle.main.url(forResource: "1", withExtension: "MP4")!
    let asset = AVURLAsset(url: movieURL)
    self.movie = try! MovieInput(asset: asset, playAtActualSpeed: true, loop: false)
    
    movie --> filter --> previewView
    
    filter --> movieOutput
    movie.start()

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
    startBtn.addTarget(self, action: #selector(onStart), for: .touchUpInside)
  }
  
  @objc private func onStart() {
    movieOutput.activateAudioTrack()
    movieOutput.startRecording()
  }
}
