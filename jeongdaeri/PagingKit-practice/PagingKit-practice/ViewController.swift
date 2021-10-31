//
//  ViewController.swift
//  PagingKit-practice
//
//  Created by dykoon on 2021/10/31.
//

import UIKit
import PagingKit

class ViewController: UIViewController {

  // MARK: - Properties
  
  var menuVC: PagingMenuViewController!
  var contentVC: PagingContentViewController!
  
  static var viewController: (UIColor) -> UIViewController = { color in
    let vc = UIViewController()
    vc.view.backgroundColor = color
    return vc
  }
  
  var dataSource = [(menuTitle: "test1", vc: viewController(.red)),
                      (menuTitle: "test2", vc: viewController(.blue)),
                      (menuTitle: "test3", vc: viewController(.yellow))]
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    menuVC.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
    // menuVC.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
    
    menuVC.registerFocusView(view: UnderlineFocusView())
    
    menuVC.cellAlignment = .center
    
    menuVC.reloadData()
    contentVC.reloadData()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? PagingMenuViewController {
      menuVC = vc
      menuVC.dataSource = self
      menuVC.delegate = self
    } else if let vc = segue.destination as? PagingContentViewController {
      contentVC = vc
      contentVC.dataSource = self
      contentVC.delegate = self
    }
  }
  

}

// MARK: - PagingMenuViewControllerDelegate

extension ViewController: PagingMenuViewControllerDelegate {
  func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
    contentVC.scroll(to: page, animated: true)
  }
}

// MARK: - PagingMenuViewControllerDataSource

extension ViewController: PagingMenuViewControllerDataSource {
  func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
    return dataSource.count
  }
  
  func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
    return 100
  }
  
  func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
    let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
    cell.titleLabel.text = dataSource[index].menuTitle
    cell.titleLabel.textColor = .black
    return cell
  }
}

// MARK: - PagingContentViewControllerDelegate

extension ViewController: PagingContentViewControllerDelegate {
  func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
    menuVC.scroll(index: index, percent: percent, animated: false)
  }
}

// MARK: - PagingContentViewControllerDataSource

extension ViewController: PagingContentViewControllerDataSource {
  func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
    return dataSource.count
  }
  
  func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
    return dataSource[index].vc
  }
}
