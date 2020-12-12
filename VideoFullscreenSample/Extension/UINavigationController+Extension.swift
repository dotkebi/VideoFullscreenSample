//
//  UINavigationController+Extension.swift
//  VideoFullscreenSample
//
//  Created by mj on 2020/12/12.
//

import UIKit
import Foundation

extension UINavigationController {

    override open var shouldAutorotate: Bool {
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.shouldAutorotate
            }
            return super.shouldAutorotate
        }
    }

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.preferredInterfaceOrientationForPresentation
            }
            return super.preferredInterfaceOrientationForPresentation
        }
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.supportedInterfaceOrientations
            }
            return super.supportedInterfaceOrientations
        }
    }
}
