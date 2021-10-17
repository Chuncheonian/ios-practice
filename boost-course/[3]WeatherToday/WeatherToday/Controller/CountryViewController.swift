//
//  ViewController.swift
//  WeatherToday
//
//  Created by dykoon on 2021/09/10.
//

import UIKit

class CountryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var countries: [Countries] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationItem.title = "세계 날씨"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)  // change navigationBar background color
        self.navigationController?.navigationBar.tintColor = .white  // change backbutton color
        
        guard let dataAsset = NSDataAsset(name: "countries") else { return }
        parseJSON(dataAsset)
    }
    
    func parseJSON(_ dataAsset: NSDataAsset) {
        let decorder = JSONDecoder()
        
        do {
            countries = try decorder.decode([Countries].self, from: dataAsset.data)
        } catch {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCityVC" {
            guard let cityVC = segue.destination as? CityViewController else { return }
            guard let cell = sender as? UITableViewCell else { return }
            guard let cellForInitials = tableView.indexPath(for: cell) else { return }
            
            cityVC.countryTitle = countries[cellForInitials.row].korean_name
            cityVC.assetName = countries[cellForInitials.row].asset_name
        }
    }
}

// MARK: - UITableViewDataSource
extension CountryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = countries[indexPath.row].korean_name
        cell.imageView?.image = UIImage(named: "flag_\(countries[indexPath.row].asset_name)")
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CountryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
