//
//  ViewController.swift
//  TabBarController-without-storyboard-tutorial
//
//  Created by dykoon on 2021/10/03.
//

import UIKit

class MyViewController: UIViewController {

    convenience init(title: String, bgColor: UIColor) {
        self.init()
        self.title = title
        self.view.backgroundColor = bgColor
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

