//
//  ViewController.swift
//  CustomPopUp-tutorial
//
//  Created by dykoon on 2021/10/03.
//

import UIKit
import WebKit

let notificationName = "btnClickNotification"

class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var mywebCiew: WKWebView!
    @IBOutlet weak var createPopUpBtn: UIButton!
    
    // MARK: - deInit
    deinit {
        // 메모리 해제
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadWebView), name: NSNotification.Name(notificationName), object: nil)
    }

    @objc fileprivate func loadWebView() {
        print("ViewController - loadWebView() called")
        
        let myChannerURL = URL(string: "https://www.instagram.com/d_oooong/")
        self.mywebCiew.load(URLRequest(url: myChannerURL!))
        
    }
    
    
    // MARK: - IBAction
    @IBAction func onCreatePopUpBtnClicked(_ sender: UIButton) {
        
        // StoryBoard 가져오기
        let storyboard = UIStoryboard.init(name: "PopUp", bundle: nil)
        
        // StoryBoard 통해 ViewController 가져오기
        let customPopUpVC = storyboard.instantiateViewController(withIdentifier: "CustomPopUpVC") as! CustomPopUpVC
        
        // ViewController가 보여지는 스타일
        customPopUpVC.modalPresentationStyle = .overCurrentContext
        
        // ViewController가 사라지는 스타일
        customPopUpVC.modalTransitionStyle = .crossDissolve
        
        customPopUpVC.subscribeBtnCompletionClosure = {
            print("컴플렉션 블럭이 호출되었다.")
            
            let myChannerURL = URL(string: "https://chuncheonian.notion.site")
            self.mywebCiew.load(URLRequest(url: myChannerURL!))
        }
        
        customPopUpVC.myPopUpDelegate = self
        
        self.present(customPopUpVC, animated: true, completion: nil)
        
    }
    
}

// MARK: - PopUpDelegate
extension ViewController: PopUpDelegate {
    
    func onGithubBtnClicked() {
        print("ViewController - onGithubBtnClicked() called")
        
        let myChannerURL = URL(string: "https://github.com/chuncheonian")
        self.mywebCiew.load(URLRequest(url: myChannerURL!))
    }
    
}
