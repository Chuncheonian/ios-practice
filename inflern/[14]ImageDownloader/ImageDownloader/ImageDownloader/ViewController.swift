//
//  ViewController.swift
//  ImageDownloader
//
//  Created by dykoon on 2021/08/24.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var downloadTask:URLSessionDownloadTask!
    
    @IBAction func downloadAction(_ sender: Any) {
        imgView.image = nil
        indicatorView.startAnimating()
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: OperationQueue.main)
        
        // closure 사용
        downloadTask = session.downloadTask(with: URL(string:"https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/sample.jpeg")!, completionHandler: {(data,response,error) -> Void in
            let dataTemp:Data = try! Data(contentsOf: data!)
            self.imgView.image = UIImage(data:dataTemp)
            self.indicatorView.stopAnimating()
            
        })
        downloadTask.resume()
    }
    
    @IBAction func suspendAction(_ sender: Any) {
        downloadTask.suspend()
    }
    
    @IBAction func resumeAction(_ sender: Any) {
        downloadTask.resume()
    }
 
    @IBAction func cancelAction(_ sender: Any) {
        downloadTask.cancel()
        progressView.setProgress(0.0, animated: false)
        indicatorView.stopAnimating()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let progress:Float = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        progressView.setProgress(progress, animated: true)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let dataTemp:Data = try! Data(contentsOf: location)
        self.imgView.image = UIImage(data:dataTemp)
        indicatorView.stopAnimating()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
