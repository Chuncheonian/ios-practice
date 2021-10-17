//
//  DetailWeatherViewController.swift
//  WeatherToday
//
//  Created by dykoon on 2021/09/10.
//

import UIKit

class DetailWeatherViewController: UIViewController {

    var cityModel: CityModel?
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var rainyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = cityModel?.cityName
        
        weatherImageView.image = UIImage(named: cityModel?.imageSet ?? "sunny")
        weatherLabel.text = cityModel?.weatherText ?? "맑음"
        tempLabel.text = "섭씨 \(cityModel?.celsius ?? 30)도 / 화씨 \(cityModel?.celToFeh ?? "80")도"
        rainyLabel.text = "강수확률 \(cityModel?.rainfallProb ?? 0)%"
        rainyLabel.textColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)        
    }
}
