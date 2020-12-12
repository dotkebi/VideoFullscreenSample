//
//  GenericViewController.swift
//  GenericViewKit
//
//  Created by Kristian Andersen on 29/05/16.
//  Copyright © 2016 Kristian Andersen. All rights reserved.
//

import UIKit

open class GenericViewController<V: GenericView>: UIViewController {
    open var contentView: V {
        return view as! V
    }

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    open override func loadView() {
        view = V()
    }
}
