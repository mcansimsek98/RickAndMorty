//
//  RMLocationVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import UIKit

class RMLocationVC: BaseVC<RMLocationVM> {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUpView() {
        self.topNavBar.title.text = ViewTitle.location
        topNavBar.hasBackButton = false
    }
}

