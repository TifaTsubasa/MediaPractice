//
//  ImageEditor.swift
//  MediaPractice
//
//  Created by tsuf on 2020/1/26.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import GPUImage

class ImageEditor {
  
  static func filter(image: UIImage) {
    
       
       // 生成GPUImagePicture
    let picture = PictureInput(image: image.cgImage!, smoothlyScaleOutput: true)
    
    let filterImageOutput = PictureOutput()

//       // 随便用一个滤镜
    let filter = SketchFilter()
    
    picture --> filter --> filterImageOutput
    picture.processImage()
//       _sepiaFilter = [[GPUImageTiltShiftFilter alloc] init];
//
//       // 如果要显示话,得创建一个GPUImageView来进行显示
    
//       GPUImageView * imageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
//       self.view = imageView;
//
//       //
//       [_sepiaFilter forceProcessingAtSize:imageView.sizeInPixels];
//
//       // 个人理解,这个add其实就是把_sourcePicture给_sepiaFilter来处理
//       [_sourcePicture addTarget:_sepiaFilter];
//       // 用这个imageView来显示_sepiaFilter处理的效果
//       [_sepiaFilter addTarget:imageView];
//
//       // 开始!
//       [_sourcePicture processImage];
  }

}
