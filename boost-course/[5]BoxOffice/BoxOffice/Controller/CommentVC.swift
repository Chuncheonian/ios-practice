//
//  CommentVC.swift
//  BoxOffice
//
//  Created by dykoon on 2021/10/05.
//

import UIKit

class CommentVC: UIViewController {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGradeImageView: UIImageView!
    @IBOutlet weak var commentWriterTextField: UITextField!
    @IBOutlet weak var commentContentsTextField: UITextField!
    
    var movieTitle: String?
    var gradeImageName: String?
    var movieID: String?
    var rating: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieTitleLabel.text = movieTitle
        movieGradeImageView.image = UIImage(named: gradeImageName!)
        
    }
    
    @IBAction func cancelComment(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    
    }
    
    //한줄평 등록 메소드
    @IBAction func uploadComment(_ sender: UIBarButtonItem) {
        //한줄평을 다 채우지 않았으면 alert 띄움
        
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        if commentWriterTextField.text?.isEmpty == true {
            let alertController = UIAlertController(title: "이름을 작성해주세요", message: nil, preferredStyle: .alert)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        } else if commentContentsTextField.text?.isEmpty == true {
            let alertController = UIAlertController(title: "한줄평을 작성해주세요", message: nil, preferredStyle: .alert)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        } else {
            requestComment()
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    //URLSession 사용 -> 한줄평 등록 메소드
     fileprivate func requestComment() {
         
         let timestamp = NSDate().timeIntervalSince1970
         let comment = CommentReq(movie_id: movieID ?? "",
                                  rating: 5,
                                  timestamp: timestamp,
                                  writer: commentWriterTextField.text ?? "",
                                  contents: commentContentsTextField.text ?? "")
         guard let uploadData = try? JSONEncoder().encode(comment) else {
             return
         }
         
         let baseURL = "http://connect-boxoffice.run.goorm.io/comment"
         
         guard let url = URL(string: baseURL) else { return }
         
         var request = URLRequest(url: url)
         request.httpMethod = "POST"
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")

         
         let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
             if error != nil { return }
             guard let response = response as? HTTPURLResponse,
                 (200...299).contains(response.statusCode) else {
                     print ("server error")
                     return
             }
             if let mimeType = response.mimeType,
                 mimeType == "application/json",
                 let data = data,
                 let dataString = String(data: data, encoding: .utf8) {
                 print ("got data: \(dataString)")
             }
         }
         task.resume()
     }
    
    
}
