//
//  RMCharacterDetailVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 18.03.2023.
//

import UIKit

final class RMCharacterDetailVC: BaseVC<RMCharacterDetailVM> {
    var character: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topNavBar.hasBackButton = true
        print(character)
    }
    
//    override func setUpView() {
//        view.addSubview(characterListView)
//        NSLayoutConstraint.activate([
//            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
//            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            characterListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
//        ])
//    }

}
