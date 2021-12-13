//
//  RegisterViewController.swift
//  NavigationVC_tutorial
//
//  Created by dykoon on 2021/10/02.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var buttonForLoginVC: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func onLoginVCBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
