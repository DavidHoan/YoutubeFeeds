//
//  VideoLaucher.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/27/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let pauseButton:UIButton = {
        let bt = UIButton(type: .system)
        let image = UIImage(named: "player-pause")
        bt.setImage(image, for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.tintColor = .white
        bt.addTarget(self, action: #selector(handlPause), for: .touchUpInside)
        return bt
    }()
    
    let indicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView:UIView  = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let videoLengthLabel:UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currentTimeLabel:UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let videoSlider:UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor  = .red
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupGradientLayer()
        setupPlayerView()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(indicatorView)
        indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive  =  true
        indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive  =  true
        
        
        controlsContainerView.addSubview(pauseButton)
        pauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive  =  true
        pauseButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive  =  true
        pauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        pauseButton.isHidden = true
        
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive  =  true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive  =  true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive  =  true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive  =  true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor, constant: -8).isActive  =  true
        //videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive  =  true
        videoSlider.centerYAnchor.constraint(equalTo: videoLengthLabel.centerYAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor, constant: -8).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        backgroundColor  = .black
    }
    
    var isPlaying = false
    @objc func handlPause() {
        
        if isPlaying {
            print("pausing player!!!")
            player?.pause()
            
            pauseButton.setImage(UIImage(named: "player-play"), for: .normal)
        } else {
            print("play player!!!")
            player?.play()
            
            pauseButton.setImage(UIImage(named: "player-pause"), for: .normal)
        }
        
        isPlaying = !isPlaying
        
    }
    
    @objc func handleSliderChange() {
        
        if let duration = player?.currentItem?.duration {
            let totalseconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalseconds
            
            let seekTime  = CMTime(seconds: value, preferredTimescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                
            })
        }
        
    }
    
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.red.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        //controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    var player:AVPlayer?
    func setupPlayerView() {
    
        let urlStr = "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
        if let url = URL(string: urlStr) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            isPlaying = true
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            
            let interval = CMTime(value: 1, timescale: 1)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { progressTime in
                
                let seconds = CMTimeGetSeconds(progressTime)
                let secondtext  = String(format:"%02d", Int(seconds) % 60 )
                let minuteText = String(format:"%02d", Int(seconds) / 60 )
                self.currentTimeLabel.text = "\(minuteText):\(secondtext)"
                
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.videoSlider.value = Float(seconds / durationSeconds)
                }
                
            })
        }
        
        /// video not player on internet server!!!
        /// https://stackoverflow.com/questions/32631184/the-resource-could-not-be-loaded-because-the-app-transport-security-policy-requi
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            print(change ?? "")
            indicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pauseButton.isHidden = false
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let secondtext  = String(format:"%02d", Int(seconds) % 60 )  //seconds.truncatingRemainder(dividingBy: 60)
                
                let minuteText = String(format:"%02d", Int(seconds) / 60 )
                videoLengthLabel.text = "\(minuteText):\(secondtext)"
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLaucher: NSObject {
    func showVideoPlayer() {
        //
        //  print(123)
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }, completion: { (completedAnimation) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}
