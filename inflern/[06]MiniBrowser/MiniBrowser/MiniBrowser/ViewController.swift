//
//  ViewController.swift
//  MiniBrowser
//
//  Created by dykoon on 2021/08/13.
//

import UIKit
import WebKit  // WKWebView를 사용하기 위해 Import

class ViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate {

    @IBOutlet weak var bookMarkSegmentedControl: UISegmentedControl!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var mainWebView: WKWebView!
    @IBOutlet weak var spinningActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initURL = "https://www.facebook.com"
        let myURL = URL(string: initURL)
        let myReq = URLRequest(url: myURL!)
        mainWebView.load(myReq)

        urlTextField.text = initURL
        
        mainWebView.navigationDelegate = self
    }


    @IBAction func bookMarkAction(_ sender: Any) {
        let bookMarkURL: String? = bookMarkSegmentedControl.titleForSegment(at: bookMarkSegmentedControl.selectedSegmentIndex)
        
        let urlString: String = "https://www.\(bookMarkURL!).com"
        mainWebView.load(URLRequest(url: URL(string: urlString)!))
        urlTextField.text = urlString
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var urlString: String = "\(urlTextField.text!)"
        if !urlString.hasPrefix("https://") {
            urlString = "https://\(urlTextField.text!)"
        }
        
        urlTextField.text = urlString
        mainWebView.load(URLRequest(url: URL(string: urlString)!))
        return true
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        spinningActivityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinningActivityIndicator.stopAnimating()
    }

    
    @IBAction func goBackAction(_ sender: Any) {
        mainWebView.goBack()
    }
    
    @IBAction func goForwardAction(_ sender: Any) {
        mainWebView.goForward()
    }
    
    @IBAction func stopLoadingAction(_ sender: Any) {
        mainWebView.stopLoading()
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        mainWebView.reload()
    }
}
