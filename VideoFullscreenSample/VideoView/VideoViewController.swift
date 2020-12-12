//
//  VideoViewController.swift
//  VideoFullscreenSample
//
//  Created by mj on 2020/12/12.
//

import UIKit
import Foundation
import AVKit

protocol VideoDelegate {

    func toggleFullscreen()
    func callbackPauseOrStop()
    func callbackPlay()
}

class VideoViewController: GenericViewController<VideoView> {

    var currentOrientation = UIApplication.shared.statusBarOrientation

    override func viewDidLoad() {
        super.viewDidLoad()

        let fullScreenButton = UIBarButtonItem(title: "full screen", style: .plain, target: self, action: #selector(delegateToggleFullscreen))
        navigationItem.rightBarButtonItem = fullScreenButton

        self.contentView.delegate = self
        self.contentView.viewDidLoad()

        self.contentView.loadData(videoUrl: "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8")

    }

    override var shouldAutorotate: Bool {
        true
    }

    @objc func delegateToggleFullscreen(_ sender: Any) {
        self.contentView.toggleFullScreen(sender)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.contentView.stop()
    }
}


extension VideoViewController: VideoDelegate {

    func toggleFullscreen() {

        var value = UIInterfaceOrientation.landscapeRight
        if UIApplication.shared.statusBarOrientation == .landscapeLeft || UIApplication.shared.statusBarOrientation == .landscapeRight {
            value = UIInterfaceOrientation.portrait
            self.show()
        } else {
            self.hide()
        }
        self.currentOrientation = value

        UIDevice.current.setValue(value.rawValue, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }

    func callbackPauseOrStop() {
        show()
    }

    func callbackPlay() {
        guard currentOrientation != .portrait else {
            print("\(currentOrientation.rawValue)")
            return
        }
        hide()
    }

    func hide() {
        UIView.animate(withDuration: 0.1, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }, completion: nil)
    }

    func show() {
        UIView.animate(withDuration: 0.1, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }, completion: nil)
    }
}

