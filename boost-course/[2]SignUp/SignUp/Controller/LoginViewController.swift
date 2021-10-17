//
//  ViewController.swift
//  SignUp
//
//  Created by dykoon on 2021/09/02.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK:- IBOutlet
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK:- IBAction
    @IBAction func signUpPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToFirstSignUp", sender: self)
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        
        if idTextField.text == UserInfomation.shared.id && passwordTextField.text == UserInfomation.shared.password {
            print("로그인 성공")
        } else {
            print("로그인 실패")
        }
    }
}

