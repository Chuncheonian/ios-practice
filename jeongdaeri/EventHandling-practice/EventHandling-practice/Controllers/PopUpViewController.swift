//
//  PopUpViewController.swift
//  EventHandling-practice
//
//  Created by dykoon on 2021/10/06.
//

import UIKit

protocol PopUpDelegate {
    func instaBtnClicked()
}

class PopUpViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var githubBtn: UIButton!
    @IBOutlet weak var notionBtn: UIButton!
    @IBOutlet weak var instaBtn: UIButton!
    
    // MARK: - Properties
    var githubBtnCompletedHandler:(() -> Void)?
    var popUpDelegate: PopUpDelegate?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.layer.cornerRadius = 30
        githubBtn.layer.cornerRadius = 10
        notionBtn.layer.cornerRadius = 10
        instaBtn.layer.cornerRadius = 10
    }
    
    // MARK: - IBActions
    @IBAction func bgBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 1. EventHandling - Completion Handler
    @IBAction func githubBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        if let githubBtnCompletedHandler = githubBtnCompletedHandler {
            githubBtnCompletedHandler()
        }
    }
    
    // 2. EventHandling - NotificationCenter
    @IBAction func notionBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
    
    // 3. EventHandling - Delegate
    @IBAction func instaBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        popUpDelegate?.instaBtnClicked()
        
    }
    
}
