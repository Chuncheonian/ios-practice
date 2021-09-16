//
//  DetailViewController.swift
//  CustomCell
//
//  Created by dykoon on 2021/08/18.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var detailDate = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgView.layer.cornerRadius = 50.0
        imgView.layer.masksToBounds = true
        
        nameLabel.text = detailDate["name"]
        amountLabel.text = detailDate["amount"]
        valueLabel.text = detailDate["value"]
        
        imgView.image = UIImage(named: detailDate["image"]!)
    }

}
