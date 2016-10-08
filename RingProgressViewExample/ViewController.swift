//
//  ViewController.swift
//  RingProgressViewExample
//
//  Created by Linsw on 16/10/8.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func setProgress(_ sender: UIButton) {
        ringProgressView.progress = 0.3
    }
    let ringProgressView = RingProgressView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = rgbColor(red: 0x3C, green: 0xA5, blue: 0x5C, alpha: 1)
        view.addSubview(ringProgressView)
        ringProgressView.setting(direction:.Clockwise)
    }

    func rgbColor(red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat)->UIColor{
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0 , alpha: alpha)
    }
}

