//
//  TabBarVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import UIKit
import RxSwift

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.tabBar.backgroundColor = .white
        }
        self.tabBar.tintColor = UIColor.green
    }
}
