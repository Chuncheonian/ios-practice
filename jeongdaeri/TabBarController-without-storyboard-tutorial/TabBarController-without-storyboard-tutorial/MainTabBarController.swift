//
//  MainTabBarController.swift
//  TabBarController-without-storyboard-tutorial
//
//  Created by dykoon on 2021/10/03.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MainTabBarController - viewDidLoad() called")
        
        let firstNC = UINavigationController.init(rootViewController: MyViewController(title: "첫번째", bgColor: .cyan))
        let secondNC = UINavigationController.init(rootViewController: MyViewController(title: "두번째", bgColor: .yellow))
        let thirdNC = UINavigationController.init(rootViewController: MyViewController(title: "세번째", bgColor: .gray))
        let forthNC = UINavigationController.init(rootViewController: MyViewController(title: "네번째", bgColor: .green))
        let fifthNC = UINavigationController.init(rootViewController: MyViewController(title: "다섯번째", bgColor: .orange))
        
        self.viewControllers = [firstNC, secondNC, thirdNC, forthNC, fifthNC]
        
        let firstTabBarItem = UITabBarItem(title: "첫번째", image: UIImage(systemName: "square.and.arrow.up"), tag: 0)
        let secondTabBarItem = UITabBarItem(title: "두번째", image: UIImage(systemName: "rectangle.portrait.and.arrow.right.fill"), tag: 1)
        let thirdTabBarItem = UITabBarItem(title: "세번째", image: UIImage(systemName: "pencil.slash"), tag: 2)
        let forthTabBarItem = UITabBarItem(title: "네번째", image: UIImage(systemName: "pencil.circle.fill"), tag: 3)
        let fifthTabBarItem = UITabBarItem(title: "다섯번째", image: UIImage(systemName: "scribble"), tag: 4)
        
        firstNC.tabBarItem = firstTabBarItem
        secondNC.tabBarItem = secondTabBarItem
        thirdNC.tabBarItem = thirdTabBarItem
        forthNC.tabBarItem = forthTabBarItem
        fifthNC.tabBarItem = fifthTabBarItem
    }
    
}
