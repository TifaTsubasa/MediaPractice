//
//  RootTableViewController.swift
//  MediaPractice
//
//  Created by tsuf on 2020/1/25.
//  Copyright © 2020 upmer. All rights reserved.
//

import UIKit
import AVKit

class RootTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let page = Page(rawValue: indexPath.row)
    switch page {
    case .player:
      let path = "\(NSTemporaryDirectory())video_audi_mix.mp4"
      let asset = AVURLAsset(url: URL(fileURLWithPath: path))
      let item = AVPlayerItem(asset: asset)
      let playerController = AVPlayerViewController()
      playerController.player = AVPlayer(playerItem: item)
      playerController.videoGravity = .resizeAspectFill
      navigationController?.pushViewController(playerController, animated: true)
//      playerController.view.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 300)
//      view.addSubview(playerController.view)
    case .cutAudio:
      navigationController?.pushViewController(CutAudioViewController(), animated: true)
    case .mixAudio:
      navigationController?.pushViewController(MixAudioViewController(), animated: true)
    case .mixVideoAudio:
      navigationController?.pushViewController(MixVideoAudioViewController(), animated: true)
    case .filterImage:
      navigationController?.pushViewController(ImageFilterViewController(), animated: true)
    case .filterCamera:
      navigationController?.pushViewController(FilterCameraViewController(), animated: true)
    default: break
    }
    print(indexPath)
  }

}

enum Page: Int {
  case player = 1
  case cutAudio
  case mixAudio
  case mixVideoAudio
  case filterImage
  case filterCamera
}
