//
//  ViewController.swift
//  WeatherTable
//
//  Created by dykoon on 2021/08/15.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var dataList = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dict1 = ["지역": "한국", "날씨": "비"]
        let dict2 = ["지역": "일본", "날씨": "맑음"]
        let dict3 = ["지역": "중국", "날씨": "눈"]
        let dict4 = ["지역": "스페인", "날씨": "우박"]
        let dict5 = ["지역": "미국", "날씨": "흐림"]
        let dict6 = ["지역": "영국", "날씨": "비"]
        let dict7 = ["지역": "프랑스", "날씨": "맑음"]
        let dict8 = ["지역": "브라질", "날씨": "눈"]
        let dict9 = ["지역": "스위스", "날씨": "우박"]
        let dict10 = ["지역": "덴마크", "날씨": "흐림"]
        let dict11 = ["지역": "스웨덴", "날씨": "비"]
        let dict12 = ["지역": "네덜란드", "날씨": "맑음"]
        let dict13 = ["지역": "크로아티아", "날씨": "눈"]
        let dict14 = ["지역": "독일", "날씨": "우박"]
        let dict15 = ["지역": "필리핀", "날씨": "흐림"]
        let dict16 = ["지역": "헝가리", "날씨": "비"]
        let dict17 = ["지역": "이탈리아", "날씨": "맑음"]
        let dict18 = ["지역": "벨기에", "날씨": "눈"]
        let dict19 = ["지역": "핀란드", "날씨": "우박"]
        
        dataList =
            [dict1,dict2,dict3,dict4,dict5,dict6,dict7,dict8,
             dict9,dict10,dict11,dict12,dict13,dict14,dict15,
             dict16,dict17,dict18,dict19
            ]
    }

    // 각 섹션에 표시할 행의 개수를 묻는 Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    // 특정 위치에 표시할 셀을 요청하는 Method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeueReusableCell: Cell을 재사용하기 위해 화면에 안보이는 Cell을 Queue에 enque, deque를 한다.
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let dicTemp: [String: String] = dataList[indexPath.row]
        
        cell.textLabel!.text = dicTemp["지역"]
        
        let weatherStr: String? = dicTemp["날씨"]
        cell.detailTextLabel!.text = weatherStr
        
        if weatherStr == "맑음" {
            cell.imageView!.image = UIImage(named: "sunny.png")
        } else if weatherStr == "비" {
            cell.imageView!.image = UIImage(named: "rainy.png")
        } else if weatherStr == "흐림" {
            cell.imageView!.image = UIImage(named: "cloudy.png")
        } else if weatherStr == "눈" {
            cell.imageView!.image = UIImage(named: "snow.png")
        } else {
        cell.imageView!.image = UIImage(named: "blizzard.png")
        }
        
        return cell
    }
}
