//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import UIKit
import RxSwift

final class RMCharacterVC: BaseVC<RMCharacterVM> {

    private let characterListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topNavBar.hasBackButton = false
        topNavBar.searchBtn.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
    }
    
    override func setUpView() {
        self.topNavBar.title.text = ViewTitle.characters
        characterListView.delegate = self
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            characterListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc
    private func didTapSearch() {
        self.viewModel.searchAction.onNext(.init(type: .character))
    } 

}

extension RMCharacterVC: RMCharacterListViewDelegate {
    func gotoDetailCharacter(_ characterName: String) {
        self.viewModel?.gotoDetailCharacter.onNext(characterName)
    }
}
