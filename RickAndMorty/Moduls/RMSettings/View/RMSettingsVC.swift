//
//  RMSettingsVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import UIKit

class RMSettingsVC: BaseVC<RMSettingsVM> {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUpView() {
        self.topNavBar.title.text = ViewTitle.settings
        topNavBar.hasBackButton = false
    }

}
