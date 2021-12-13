//
//  ViewController.swift
//  NavigationVC_tutorial
//
//  Created by dykoon on 2021/10/02.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        loginBtn.addTarget(self, action: #selector(moveToMainViewController), for: .touchUpInside)
    }

    // 메인화면으로 이동
    @objc fileprivate func moveToMainViewController() {
        print("LoginViewController - moveToMainViewController() called")
        
        let mainVC = MainViewController()
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    

}

