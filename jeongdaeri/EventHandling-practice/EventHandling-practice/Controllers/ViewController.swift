//
//  ViewController.swift
//  EventHandling-practice
//
//  Created by dykoon on 2021/10/06.
//

import UIKit
import WebKit

let notificationName = NSNotification.Name("btnClickNotification")

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadNotion), name: notificationName, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Methods
    // 2. EventHandling - NotificationCenter
    @objc fileprivate func loadNotion() {
        print("Notion 버튼이 눌렸습니다.")
        webViewLoad(urlString: "https://chuncheonian.notion.site")
    }
    
    fileprivate func webViewLoad(urlString: String) {
        let url: URL = URL(string: urlString)!
        webView.load(URLRequest(url: url))
    }
    
    // MARK: - IBActions
    @IBAction func popUpBtnClicked(_ sender: UIButton) {
        
        let popUpStoryboard = UIStoryboard.init(name: "PopUpView", bundle: nil)

        guard let popUpVC = popUpStoryboard.instantiateViewController(withIdentifier: "popUpVC") as? PopUpViewController else { return }
        
        // ViewController가 보여지는 스타일
        popUpVC.modalPresentationStyle = .overCurrentContext
   
        // ViewController가 사라지는 스타일
        popUpVC.modalTransitionStyle = .crossDissolve
        
        // 1. EventHandling - Completion Handler
        popUpVC.githubBtnCompletedHandler = {
            print("Github 버튼이 눌렸습니다.")
            self.webViewLoad(urlString: "https://www.github.com/chuncheonian")
        }
        
        popUpVC.popUpDelegate = self
        
        self.present(popUpVC, animated: true, completion: nil)
    }
    
    
}

extension ViewController: PopUpDelegate {
    
    // 3. EventHandling - Delegate
    func instaBtnClicked() {
        print("Instagram 버튼이 눌렸습니다.")
        webViewLoad(urlString: "https://www.instagram.com/d_oooong/")
    }
}
