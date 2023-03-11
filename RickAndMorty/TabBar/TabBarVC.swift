//
//  TabBarVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import UIKit
import RxSwift

class TabBarVC: UITabBarController {
    
    var underLineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.tabBar.backgroundColor = UIColor(named: "TabBarColor")
            self.addTabbarIndicatorView(index: 0, isFirstTime: true)
        }
        self.tabBar.tintColor = .black
  
    }
    
    func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false){
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else { return}
        if !isFirstTime{
            underLineView.removeFromSuperview()
        }
        underLineView = UIView(frame: CGRect(x: tabView.frame.minX + 19, y: tabView.frame.maxY + 2,
                                             width: tabView.frame.size.width - 12 * 3.2, height: 4))
        underLineView.backgroundColor = .black
        tabBar.addSubview(underLineView)

    }
    
}

extension TabBarVC: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let items = tabBar.items, let index = items.firstIndex(of: item) else { return }
        self.addTabbarIndicatorView(index: index)
    }
}

