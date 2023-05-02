//
//  RMEpisodeVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import UIKit
import RxSwift

class RMEpisodeVC: BaseVC<RMEpisodeVM> {
    private let episodeListView = RMEpisodeListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        topNavBar.searchBtn.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
    }

    override func setUpView() {
        self.topNavBar.title.text = ViewTitle.episode
        topNavBar.hasBackButton = false
        view.addSubview(episodeListView)
        episodeListView.delegate = self
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            episodeListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            episodeListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc
    private func didTapSearch() {
        self.viewModel.searchAction.onNext(.init(type: .episode))
    }

}

extension RMEpisodeVC: RMEpisodeListViewDelegate {
    func gotoDetailEpisode(_ episode: String) {
        self.viewModel?.gotoDetailEpisode.onNext(episode)
    }
}
