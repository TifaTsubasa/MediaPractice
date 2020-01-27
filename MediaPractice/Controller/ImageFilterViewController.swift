//
//  ImageFilterViewController.swift
//  MediaPractice
//
//  Created by tsuf on 2020/1/26.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import GPUImage

class ImageFilterViewController: UIViewController {
  
  private weak var imageView: RenderView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let imageView = RenderView()
    imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
    imageView.contentMode = .scaleAspectFill
    view.addSubview(imageView)
    self.imageView = imageView
    
    let image = UIImage(contentsOfFile: Bundle.main.path(forResource: "1", ofType: "JPG")!)!
    let picture = PictureInput(image: image.cgImage!, smoothlyScaleOutput: true)
    
    let filter = LookupFilter()
    filter.lookupImage = PictureInput(image:UIImage(named:"lut_abao.png")!)
    
    picture --> filter --> imageView
    picture.processImage()
  }
  
}
