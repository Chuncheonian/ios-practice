//
//  FirstSignUpViewController.swift
//  SignUp
//
//  Created by dykoon on 2021/09/02.
//

import UIKit

class FirstSignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    // MARK:- IBOutlet
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    
    // MARK:- Property
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true // 편집 허용
        picker.delegate = self  // ViewController가 picker의 delegate 역할을 한다.
        return picker
    }()
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate
        idTextField.delegate = self
        passwordTextField.delegate = self
        rePasswordTextField.delegate = self
        introduceTextView.delegate = self
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchToPickPhoto(_:)))
        imageViewer.addGestureRecognizer(tapGesture)
        imageViewer.isUserInteractionEnabled = true
        
        nextButton.isEnabled = false
    }
    
    // MARK:- IBAction
    @IBAction func imageButtonPressed(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        UserInfomation.shared.id = nil
        UserInfomation.shared.password = nil
        UserInfomation.shared.introduce = nil
        UserInfomation.shared.profilePhoto = nil
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        UserInfomation.shared.id = idTextField.text
        UserInfomation.shared.password = passwordTextField.text
        UserInfomation.shared.introduce = introduceTextView.text
        UserInfomation.shared.profilePhoto = imageViewer.image
    }
    
    // MARK:- Method
    @objc func touchToPickPhoto(_ sender: UITapGestureRecognizer) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    
    func checkUserInfo() {
        if idTextField.text?.isEmpty != true &&
            passwordTextField.text?.isEmpty != true &&
            introduceTextView.text?.isEmpty != true &&
            imageViewer.image != nil &&
            passwordTextField.text == rePasswordTextField.text
        {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    // MARK:- UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkUserInfo()
    }
    
    // MARK:- UITextViewDelegate
    func textViewDidEndEditing(_ textView: UITextView) {
        checkUserInfo()
    }
    
    // MARK:- UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageViewer.image = editedImage
        }
        
        self.dismiss(animated: true, completion: nil)
        checkUserInfo()
    }
}
