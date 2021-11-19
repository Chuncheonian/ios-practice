//
//  ViewController.swift
//  CompletionBlock-tutorial
//
//  Created by dykoon on 2021/10/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewController - viewDidLoad() called")
        
        sayHi(completion: {
            print("sayHi 끝났음")
        })
    }

    fileprivate func sayHi(completion: @escaping() -> ()) {
        print("ViewController - sayHi() called")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            print("Hi")
            completion()
        }
    }

}

