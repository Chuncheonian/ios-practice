//
//  MovieInfoTVC.swift
//  BoxOffice
//
//  Created by dykoon on 2021/10/05.
//

import UIKit

class MovieInfoTVC: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGradeImageView: UIImageView!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieGenreDurationLabel: UILabel!
    
    @IBOutlet weak var movieReservationLabel: UILabel!
    @IBOutlet weak var audienceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieImageView.image = UIImage(named: "img_placeholder")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
