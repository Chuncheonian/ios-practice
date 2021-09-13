//
//  ViewController.swift
//  AppLifeCycle
//
//  Created by dykoon on 2021/08/11.
//

import UIKit

class ViewController: UIViewController {

//    // storyboard 안쓰고 직접 코드로 작성할 때만 사용
//    override func loadView() {
//        super.loadView()
//        self.view.backgroundColor = .red
//        print("loadView")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.view.backgroundColor = .blue
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        self.view.backgroundColor = .red
    }

    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
}
