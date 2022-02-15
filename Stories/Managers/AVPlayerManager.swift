//
//  AVPlayerManager.swift
//  Stories
//
//  Created by Abdullah on 10/02/2022.
//

import Foundation
import AVKit

class AVPlayerManager {
    
    var avPlayer: AVPlayer?
    var videoView: UIView?
    private var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        return activityView
    }()
    
    func showVideo(with videoUrl: String?) {
        showLoader()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        DispatchQueue.main.async {
            guard let url = URL(string: videoUrl ?? "") else { return }
            let asset = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset)
            self.avPlayer = AVPlayer(playerItem: playerItem)
            let playerLayer = AVPlayerLayer(player: self.avPlayer)
            guard let videoView = self.videoView else { return }
            playerLayer.frame = videoView.bounds
            
            videoView.layer.insertSublayer(playerLayer, at: 0)
            
            self.avPlayer?.play()
            
            self.isVideStarted()
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
    }
    
    private func showLoader() {
        videoView?.addSubview(activityView)
        activityView.centerInSuperview()
        activityView.startAnimating()
        videoView?.bringSubviewToFront(activityView)
    }
    
    private func stopLoader() {
        activityView.stopAnimating()
    }
    
    private func isVideStarted() {
        let interval = CMTime(value: 1, timescale: 2)
        self.avPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [weak self] time in
            if self?.avPlayer?.currentItem?.status == AVPlayerItem.Status.readyToPlay {
                self?.stopLoader()
            }
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

