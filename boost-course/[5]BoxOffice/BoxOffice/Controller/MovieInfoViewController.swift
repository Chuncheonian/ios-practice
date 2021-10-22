//
//  MovieInfoViewController.swift
//  BoxOffice
//
//  Created by dykoon on 2021/09/29.
//

import UIKit

class MovieInfoViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var movieID: String?
    var movieInfo: MovieInfo?
    var comments: [Comment] = []
    var movieInfoManager = MovieInfoManager()
    var commentsManager = CommentsManager()
    let cellIdentifiers: [String] = ["MovieInfoCell", "SynopsisCell", "DirectorCell", "CommentTitleCell", "CommentsCell"]
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(MovieInfoNotification), name: MovieInfoNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CommentsNotification), name: CommentsNotificationName, object: nil)
        
        movieInfoManager.fetchMovieInfo(movieID: movieID!)
        commentsManager.fetchComments(movieID: movieID!)
        
    }
    
    // MARK: - Methods
    @objc func MovieInfoNotification(_ noti: Notification) {
        
        guard let movieInfo: MovieInfo = noti.userInfo?["movieInfo"] as? MovieInfo else { return }
        
        self.movieInfo = movieInfo
        
        DispatchQueue.main.async {
            self.navigationItem.title = movieInfo.title
            self.tableView.reloadData()
        }
    }
    
    @objc func CommentsNotification(_ noti: Notification) {
        
        guard let comments: [Comment] = noti.userInfo?["comments"] as? [Comment] else { return }
        
        self.comments = comments
        
        print(self.comments)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let commentVC = segue.destination as? CommentVC else { return }
        
        commentVC.movieTitle = movieInfo?.title
        commentVC.gradeImageName = movieInfo?.setGradeImageName
        commentVC.movieID = movieID
    }
    
}

// MARK: - UITableViewDataSource
extension MovieInfoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 2, 3:
            return 1
        default:
            return comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[section], for: indexPath)
     
        guard let movieInfo = movieInfo else { return UITableViewCell() }
     
        switch section {
        case 0:
            guard let movieInfoCell = cell as? MovieInfoTVC else {
                return UITableViewCell()
            }
            
            movieInfoCell.movieTitleLabel.text = movieInfo.title
            movieInfoCell.movieGradeImageView.image = UIImage(named: movieInfo.setGradeImageName)
            movieInfoCell.movieDateLabel.text = "\(movieInfo.date)개봉"
            movieInfoCell.movieGenreDurationLabel.text = movieInfo.GenreDurationText
            movieInfoCell.movieReservationLabel.text = movieInfo.reservationText
            movieInfoCell.audienceLabel.text = movieInfo.audienceFormat
            
            DispatchQueue.global().async {
                guard let imageURL: URL = URL(string: movieInfo.image) else { return }
                guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }

                DispatchQueue.main.async {
                    if let index: IndexPath = tableView.indexPath(for: cell) {
                        if index.row == indexPath.row {
                            movieInfoCell.movieImageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        case 1:
            guard let synopsisCell = cell as? SynopsisTVC else {
                return UITableViewCell()
            }
            synopsisCell.synopsisLabel.text = movieInfo.synopsis

        case 2:
            guard let directorCell = cell as? DirectorTVC else {
                return UITableViewCell()
            }
            directorCell.directorLabel.text = movieInfo.director
            directorCell.actorLabel.text = movieInfo.actor
            
        case 3:
            guard let commentTitleCell = cell as? CommentTitleTVC else {
                return UITableViewCell()
            }
            
        case 4:
            guard let commentsCell = cell as? CommentsTVC else {
                return UITableViewCell()
            }

            commentsCell.writerLabel.text = comments[indexPath.row].writer
            commentsCell.timestampLabel.text = "\(comments[indexPath.row].timestampToDateFormat)"
            commentsCell.contentsLabel.text = comments[indexPath.row].contents

        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "
    }

}

extension MovieInfoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
}

