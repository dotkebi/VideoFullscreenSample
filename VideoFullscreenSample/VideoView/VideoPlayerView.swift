//
//  VideoView.swift
//  PalmLive
//
//  Created by mj on 2020/08/27.
//  Copyright © 2020 hsjl. All rights reserved.
//

import AVFoundation
import UIKit

class VideoPlayerView: UIView {
    var player: AVPlayer? {
        get {
            playerLayer.player
        }

        set {
            playerLayer.player = newValue
        }
    }

    override class var layerClass: AnyClass {
        AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
        layer as! AVPlayerLayer
    }
}
