//
//  ViewController.swift
//  VideoFullscreenSample
//
//  Created by mj on 2020/12/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var showButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }

    @IBAction func showButtonClicked(_ sender: Any) {
        let vc = VideoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

