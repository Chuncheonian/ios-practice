//
//  AlbumCollectionViewCell.swift
//  MyAlbum
//
//  Created by dykoon on 2021/09/15.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.imageView.layer.cornerRadius = 8
        self.imageView.contentMode = .scaleAspectFill
    }

}
