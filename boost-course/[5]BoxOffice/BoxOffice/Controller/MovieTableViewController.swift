//
//  ViewController.swift
//  BoxOffice
//
//  Created by dykoon on 2021/09/28.
//

import UIKit

class MovieTableViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var movieTableView: UITableView!
    
    // MARK: - Properties
    let movieCellIdentifier: String = "moviesCell"
    var movies: [Movie] = []
    var movieManager = MoviewManager()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: movieCellIdentifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MoviesNotification), name: MoviesNotificationName, object: nil)
        
        movieManager.fetchMovies(orderType: 0)
    }

    // MARK: - Method
    @objc func MoviesNotification(_ noti: Notification) {
        
        guard let movies: [Movie] = noti.userInfo?["movies"] as? [Movie] else { return }
        
        self.movies = movies
        
        DispatchQueue.main.async {
            self.movieTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension MovieTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = movieTableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie: Movie = self.movies[indexPath.row]
        cell.movieTitleLabel.text = movie.title
        cell.movieGradeImageView.image = UIImage(named: movie.setGradeImageName)
        cell.movieInfoLabel.text = movie.movieTableInfo
        cell.movieDateLabel.text = "개봉일 : \(movie.date)"
        
        DispatchQueue.global().async {
            guard let movieImageURL: URL = URL(string: movie.thumb) else { return }
            guard let movieImageData: Data = try? Data(contentsOf: movieImageURL) else { return }

            DispatchQueue.main.async {
                if let index: IndexPath = self.movieTableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.movieImage.image = UIImage(data: movieImageData)
                    }
                }
            }
        }
        return cell
    }
}

extension MovieTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let movieInfoVC = self.storyboard?.instantiateViewController(identifier: "MovieInfoVC") as? MovieInfoViewController else {
            return
        }
        
        movieInfoVC.movieID = movies[indexPath.row].id
        self.navigationController?.pushViewController(movieInfoVC, animated: true)
    }
    
}
