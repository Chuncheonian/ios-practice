//
//  CommentsManager.swift
//  BoxOffice
//
//  Created by dykoon on 2021/10/05.
//

import UIKit

let CommentsNotificationName: Notification.Name = Notification.Name("CommentsNotificationName")

struct CommentsManager {

    let commentsBaseURL = "https://connect-boxoffice.run.goorm.io/comments?movie_id="
    
    func fetchComments(movieID: String) {
        let urlString = "\(commentsBaseURL)\(movieID)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let apiResponse = try JSONDecoder().decode(Comments.self, from: data)
                    
                    NotificationCenter.default.post(name: CommentsNotificationName, object: nil, userInfo: ["comments" : apiResponse.comments])
                } catch (let err){
                    print(err.localizedDescription)
                }
                
            }
            task.resume()
        }
    }
}
