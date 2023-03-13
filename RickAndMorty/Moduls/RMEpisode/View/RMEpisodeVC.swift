//
//  RMEpisodeVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import UIKit

class RMEpisodeVC: BaseVC<RMEpisodeVM> {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUpView() {
        self.topNavBar.title.text = ViewTitle.episode
        topNavBar.hasBackButton = false
    }

}
