//
//  SearchVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 2.05.2023.
//

import UIKit

struct Config {
    enum `Type` {
        case character
        case episode
        case location
    }
    let type: `Type`
}

class SearchVC: BaseVC<SearchVM> {
    var config: Config?

    override func viewDidLoad() {
        super.viewDidLoad()
        topNavBar.hasBackButton = true
        topNavBar.detailPageName.text = "Search"
        topNavBar.shareBtn.isHidden = true
        
        if let config = config {
            print(config.type)
        }
    }

}
