//
//  CityViewController.swift
//  WeatherToday
//
//  Created by dykoon on 2021/09/10.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var countryTitle: String?
    var assetName: String?
    var cityDataArr: [CityData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationItem.title = countryTitle
        
        guard let dataAsset = NSDataAsset(name: assetName!) else { return }
        parseJSON(dataAsset)
    }
    
    func parseJSON(_ dataAsset: NSDataAsset) {
        let decorder = JSONDecoder()
        
        do {
            cityDataArr = try decorder.decode([CityData].self, from: dataAsset.data)
        
        } catch {
            print(error)
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDetailVC" {
            guard let detailVC = segue.destination as? DetailWeatherViewController else { return }
            guard let customCell = sender as? UITableViewCell else { return }
            guard let cellForInitials = tableView.indexPath(for: customCell) else { return }
            
            let cityName = cityDataArr[cellForInitials.row].city_name
            let celsius = cityDataArr[cellForInitials.row].celsius
            let state = cityDataArr[cellForInitials.row].state
            let rainfallProb = cityDataArr[cellForInitials.row].rainfall_probability
            
            let cityModel = CityModel(cityName: cityName, celsius: celsius, state: state, rainfallProb: rainfallProb)
            
            detailVC.cityModel = cityModel
        }
    }
}

extension CityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! WeathTableViewCell
        
        let cityName = cityDataArr[indexPath.row].city_name
        let celsius = cityDataArr[indexPath.row].celsius
        let state = cityDataArr[indexPath.row].state
        let rainfallProb = cityDataArr[indexPath.row].rainfall_probability
        
        let cityData = CityModel(cityName: cityName, celsius: celsius, state: state, rainfallProb: rainfallProb)
        
        customCell.cityLabel.text = cityData.cityName
        
        customCell.tempLabel.text = "섭씨 \(cityData.celsius)도 / 화씨 \(cityData.celToFeh)도"
        customCell.rainyLabel.text = "강수확률 \(cityData.rainfallProb)%"
        customCell.rainyLabel.textColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        customCell.imageView?.image = UIImage(named: cityData.imageSet)
        
        customCell.accessoryType = .disclosureIndicator
        
        return customCell
    }
}

// MARK: - UITableViewDelegate
extension CityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
