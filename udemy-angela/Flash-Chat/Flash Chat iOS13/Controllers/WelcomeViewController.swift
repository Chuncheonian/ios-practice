//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = K.appName
    }
    
    // viewWillAppear : 아직 눈에 안보이는 상태, UI 같은 거 숨길 때 사용
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // viewWillDisappear : 다른 VC로 넘어갈 때 그 다음 UI 변경 때 사용
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}
