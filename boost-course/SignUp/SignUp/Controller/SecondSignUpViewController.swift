//
//  SecondSignUpViewController.swift
//  SignUp
//
//  Created by dykoon on 2021/09/02.
//

import UIKit

class SecondSignUpViewController: UIViewController, UITextFieldDelegate {

    // MARK:- IBOutlet
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK:- Property
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberTextField.delegate = self
        
        signUpButton.isEnabled = false
        
        let date: Date = datePicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        self.birthLabel.text = dateString
    }
    
    // MARK:- IBAction
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker) {
        let date: Date = sender.date
        let dateString: String = self.dateFormatter.string(from: date)
        self.birthLabel.text = dateString
        
        checkUserInfo()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        UserInfomation.shared.id = nil
        UserInfomation.shared.password = nil
        UserInfomation.shared.introduce = nil
        UserInfomation.shared.profilePhoto = nil
        UserInfomation.shared.phoneNumber = nil
        UserInfomation.shared.dateOfBirth = nil
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        UserInfomation.shared.phoneNumber = nil
        UserInfomation.shared.dateOfBirth = nil
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func completedPressed(_ sender: UIButton) {
        UserInfomation.shared.phoneNumber = phoneNumberTextField.text
        UserInfomation.shared.dateOfBirth = datePicker.date
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK:- UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkUserInfo()
    }
    
    
    // MARK:- Function
    func checkUserInfo() {
        if phoneNumberTextField.text?.isEmpty != true {
            signUpButton.isEnabled = true
        } else {
            signUpButton.isEnabled = false
        }
    }
}
