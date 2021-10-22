//
//  MovieInfoManager.swift
//  BoxOffice
//
//  Created by dykoon on 2021/10/05.
//

import UIKit

let MovieInfoNotificationName: Notification.Name = Notification.Name("MovieInfoNotificationName")

struct MovieInfoManager {

    let movieInfoBaseURL = "https://connect-boxoffice.run.goorm.io/movie?id="
    
    func fetchMovieInfo(movieID: String) {
        let urlString = "\(movieInfoBaseURL)\(movieID)"
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
                    let apiResponse = try JSONDecoder().decode(MovieInfo.self, from: data)
                    NotificationCenter.default.post(name: MovieInfoNotificationName, object: nil, userInfo: ["movieInfo" : apiResponse])
                } catch (let err){
                    print(err.localizedDescription)
                }
                
            }
            task.resume()
        }
    }
}
