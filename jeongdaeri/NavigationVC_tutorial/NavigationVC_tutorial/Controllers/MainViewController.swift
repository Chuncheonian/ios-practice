//
//  MainViewController.swift
//  NavigationVC_tutorial
//
//  Created by dykoon on 2021/10/02.
//

import UIKit

class MainViewController: UIViewController {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "메인화면"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        return label
    }()
    
    let changeBtn: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.setTitle("배경색 바꾸기", for: .normal)
//        btn.setTitleColor(.black, for: .normal)
//        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        btn.backgroundColor = .white
//        btn.layer.cornerRadius = 5
//        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
//        btn.addTarget(self, action: #selector(changeBG), for: .touchUpInside)
        
        // iOS15 변경점
        var configuration = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 20)
        configuration.attributedTitle = AttributedString("배경색바꾸기", attributes: container)
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        configuration.background.cornerRadius = 5
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20)

        return UIButton(configuration: configuration, primaryAction: nil)
    }()
    
    var isBGOrange: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isBGOrange = true
        
        view.backgroundColor = .orange
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true  // 정가운데
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true  // 정가운데
        
//        changeBtn.addTarget(self, action: #selector(changeBG), for: .touchUpInside)
        changeBtn.configurationUpdateHandler = { button in
            switch button.state {
            case .highlighted:
                button.configuration?.title = "Highlighted"
            default:
                button.configuration?.title = "Normal"
            }
        }
        
        changeBtn.isEnabled = true
        
        view.addSubview(changeBtn)
        
        changeBtn.translatesAutoresizingMaskIntoConstraints = false
        changeBtn.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        changeBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true  // 정가운데
        
    }
    
    
    @objc fileprivate func changeBG() {
        
        if isBGOrange == true {
            view.backgroundColor = .yellow
            isBGOrange = false
        } else {
            view.backgroundColor = .orange
            isBGOrange = true
        }
        
        print("MainViewController - changeBG() called isBGOrange : \(String(describing: isBGOrange))")
    }
}


extension UIButton.Configuration {
    public static func outline() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIButton.Configuration.plain().background
        background.cornerRadius = 20
        background.strokeWidth = 1
        background.strokeColor = UIColor.systemGray5
        style.background = background
        
        return style
    }
}
