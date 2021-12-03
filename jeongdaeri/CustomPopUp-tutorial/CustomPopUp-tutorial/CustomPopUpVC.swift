//
//  CustomPopUpVC.swift
//  CustomPopUp-tutorial
//
//  Created by dykoon on 2021/10/04.
//

import UIKit

class CustomPopUpVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var subscribeBtn: UIButton!
    @IBOutlet weak var githubBtn: UIButton!
    @IBOutlet weak var instagramBtn: UIButton!
    
    // MARK: - Properties
    var subscribeBtnCompletionClosure: (() -> Void)?
    var myPopUpDelegate: PopUpDelegate?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
        contentView.layer.cornerRadius = 30
        subscribeBtn.layer.cornerRadius = 10
        githubBtn.layer.cornerRadius = 10
        instagramBtn.layer.cornerRadius = 10
    }
    
    // MARK: - IBAction
    @IBAction func onInstaBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name(notificationName), object: nil)
    }
    
    @IBAction func onBgBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onGithubBtnClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
        // 메인에 알린다.
        myPopUpDelegate?.onGithubBtnClicked()
    }
    
    @IBAction func onSubscribeBtnClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let subscribeBtnCompletionClosure = subscribeBtnCompletionClosure {
            
            // 메인에 알린다.
            subscribeBtnCompletionClosure()
        }
    }
}
