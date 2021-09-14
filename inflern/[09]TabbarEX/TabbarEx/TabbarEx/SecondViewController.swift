//
//  SecondViewController.swift
//  TabbarEx
//
//  Created by dykoon on 2021/08/14.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        outputLabel.text = "2번 버튼이 눌렸습니다."
    }
}
