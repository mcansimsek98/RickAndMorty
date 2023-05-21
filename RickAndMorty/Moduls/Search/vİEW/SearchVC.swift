//
//  SearchVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 2.05.2023.
//

import UIKit

class SearchVC: BaseVC<SearchVM> {
    var config: Config?
    private let inputSearchView = SearchInputView()
    private let noResultView = RMNoSearchResulView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addContstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presentKeyboard()
    }
    
    private func configure() {
        topNavBar.hasBackButton = true
        topNavBar.shareBtn.isHidden = true
        topNavBar.searchDelegate = self
        topNavBar.hasSearchDetailButton = true
        view.addSubViews(inputSearchView, noResultView)
        inputSearchView.delegate = self
        if let config = config {
            topNavBar.detailPageName.text = config.type.title
            inputSearchView.configure(with: SearchInputViewVM(type: config.type))
        }
        
        viewModel.registerOptionChangeBlock { tuple in
            self.inputSearchView.update(option: tuple.0, value: tuple.1)
        }
    }
    
    private func addContstraints() {
        NSLayoutConstraint.activate([
            inputSearchView.topAnchor.constraint(equalTo: self.topNavBar.bottomAnchor),
            inputSearchView.leftAnchor.constraint(equalTo: view.leftAnchor),
            inputSearchView.rightAnchor.constraint(equalTo: view.rightAnchor),
            inputSearchView.heightAnchor.constraint(equalToConstant: config?.type == .episode ? 55 : 110),
            
            noResultView.widthAnchor.constraint(equalToConstant: 150),
            noResultView.heightAnchor.constraint(equalToConstant: 150),
            noResultView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    public func presentKeyboard() {
        inputSearchView.presentKeyboard()
    }
}

// MARK: TopNavBarSearchDetailDelegate
extension SearchVC: TopNavBarSearchDetailDelegate {
    func searchBtnAction() {
        viewModel.executeSearc()
    }
}

// MARK: SearchInputViewDelegate
extension SearchVC: SearchInputViewDelegate {
    func searchInputView(_ inputView: SearchInputView, didSelectOptions option: SearchInputViewVM.DynamicOptions) {
        self.viewModel.goToSearchPicerVC.onNext(option)
    }
}
