//
//  VideoView.swift
//  PalmLive
//
//  Created by mj on 2020/08/27.
//  Copyright © 2020 hsjl. All rights reserved.
//

import SnapKit
import Foundation
import UIKit
import AVFoundation
import AVKit

class VideoView: GenericView {

    var delegate: VideoDelegate?
    var player = AVPlayer()

    private(set) var toolbar = UIToolbar()
    private(set) var videoPlayerView = VideoPlayerView()
    private(set) var playButton = UIButton()
    private(set) var fullscreenButton = UIButton()

    private(set) var someView = UIView()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        return activityIndicator
    }()

    override func configureView() {
        super.configureView()

        initializeUI()
        createConstraints()
        addGestureRecognizers()
    }

    deinit {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func play() {
        self.delegate?.callbackPlay()
        self.player.play()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.playButton.isHidden = true

            if !self.activityIndicator.isHidden {
                self.activityIndicator.stopAnimating()
            }
        }
    }

    func pause() {
        self.delegate?.callbackPauseOrStop()
        self.player.pause()
        self.playButton.isHidden = false
    }

    func stop() {
        self.delegate?.callbackPauseOrStop()
        self.player.seek(to: CMTime.zero)
        self.player.pause()
        self.playButton.isHidden = false
    }


    private func initializeUI() {
        backgroundColor = UIColor.white

        self.videoPlayerView.backgroundColor = UIColor(red: 38.0 / 255.0, green: 38.0 / 255.0, blue: 40.0 / 255.0, alpha: 1.0)
        addSubview(self.videoPlayerView)

        self.playButton.setTitle("Play", for: .selected)
        self.playButton.setTitle("Pause", for: .normal)
        self.playButton.setTitleColor(UIColor.white, for: .selected)
        self.playButton.setTitleColor(UIColor.white, for: .normal)
        self.playButton.addTarget(self, action: #selector(self.togglePlayMode), for: .touchUpInside)
        self.playButton.isHidden = true

        addSubview(self.playButton)

        self.someView.backgroundColor = UIColor(red: 138.0 / 255.0, green: 138.0 / 255.0, blue: 40.0 / 255.0, alpha: 1.0)
        addSubview(self.someView)

        addSubview(self.activityIndicator)
    }

    func addGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.togglePlayMode))

        self.videoPlayerView.addGestureRecognizer(tap)
    }

    private func createConstraints() {
        let ratio = 9.0 / 16.0
        self.videoPlayerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(210)
            make.height.equalTo(self.videoPlayerView.snp.width).multipliedBy(ratio)
        }

        self.activityIndicator.snp.makeConstraints { make in
            make.edges.equalTo(self.videoPlayerView)
        }

        self.playButton.snp.makeConstraints { make in
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.centerX.equalTo(self.videoPlayerView)
            make.centerY.equalTo(self.videoPlayerView)
        }

        self.someView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.videoPlayerView.snp.bottom)
            make.height.equalTo(100)
        }


    }

    @objc func togglePlayMode(_ sender: Any) {
        let flag = self.playButton.isSelected
        self.playButton.isSelected = !flag

        if flag {
            self.play()
        } else {
            self.pause()
        }
    }

    @objc func toggleFullScreen(_ sender: Any) {
        print("toggleFullScreen")
        self.delegate?.toggleFullscreen()
    }

    func makePlayerItem(url: URL) -> AVPlayer {

        let asset = AVURLAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        return AVPlayer(playerItem: item)
    }

    func loadData(videoUrl: String) {

        guard let url = URL(string: videoUrl) else {
            return
        }

        player = makePlayerItem(url: url)
        self.videoPlayerView.player = player

        player.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions(rawValue: NSKeyValueObservingOptions.new.rawValue | NSKeyValueObservingOptions.old.rawValue), context: nil)

        self.play()
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "rate" {
            if player.rate == 1 {
                print("Playing")
                self.playButton.isSelected = false
            } else {
                print("Stop")
                self.playButton.isSelected = true
            }
        }
    }


}
