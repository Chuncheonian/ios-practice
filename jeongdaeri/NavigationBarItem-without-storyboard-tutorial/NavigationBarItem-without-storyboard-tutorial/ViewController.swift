//
//  ViewController.swift
//  NavigationBarItem-without-storyboard-tutorial
//
//  Created by dykoon on 2021/10/03.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "홈"
        self.view.backgroundColor = .yellow

        // add Navigation Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(goToProfileVC))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "message.fill"), style: .plain, target: self, action: #selector(goToMessageVC))
        
    }
    
    @objc fileprivate func goToProfileVC() {
        let profileVC = ProfileVC()
        
        self.navigationController?.pushViewController(profileVC, animated: true)
    }

    @objc fileprivate func goToMessageVC() {
        let messageVC = MessageVC()
        
        self.navigationController?.pushViewController(messageVC, animated: true)
        
        
    }
    
}

