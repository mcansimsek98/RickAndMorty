//
//  RMEpisodeDetailCV.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 30.04.2023.
//

import UIKit

final class RMEpisodeDetailCV: BaseVC<RMEpisodeDetailVM> {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        topNavBar.hasBackButton = true
        topNavBar.detailPageName.text = "Episode"
        
        print("Episode:", self.viewModel.episodeId)
    }

}
