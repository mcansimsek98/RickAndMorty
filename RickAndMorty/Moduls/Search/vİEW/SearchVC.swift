//
//  SearchVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 2.05.2023.
//

import UIKit

class SearchVC: BaseVC<SearchVM> {
    var config: Config?
    private var searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addContstraints()
    }
    
    private func configure() {
        topNavBar.hasBackButton = true
        topNavBar.shareBtn.isHidden = true
        topNavBar.searchDelegate = self
        topNavBar.hasSearchDetailButton = true
        view.addSubview(searchView)
        if let config = config {
            topNavBar.detailPageName.text = config.type.title
        }
    }
    
    private func addContstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension SearchVC: TopNavBarSearchDetailDelegate {
    func searchBtnAction() {
        
    }
}
