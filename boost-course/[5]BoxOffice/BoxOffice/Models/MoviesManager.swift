//
//  MoviesManager.swift
//  BoxOffice
//
//  Created by dykoon on 2021/09/29.
//

import UIKit

let MoviesNotificationName: Notification.Name = Notification.Name("MoviesNotificationName")

struct MoviewManager {

    let moviesBaseURL = "https://connect-boxoffice.run.goorm.io/movies?order_type="
    
    func fetchMovies(orderType: Int) {
        let urlString = "\(moviesBaseURL)\(orderType)"
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
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                    NotificationCenter.default.post(name: MoviesNotificationName, object: nil, userInfo: ["movies" : apiResponse.movies])
                } catch (let err){
                    print(err.localizedDescription)
                }
                
            }
            task.resume()
        }
    }
}
