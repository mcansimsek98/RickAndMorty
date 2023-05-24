//
//  SearchVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 2.05.2023.
//

import UIKit
import RxSwift

class SearchVC: BaseVC<SearchVM> {
    
    private let inputSearchView = SearchInputView()
    private let noResultView = RMNoSearchResulView()
    private let resultView = SearchResultView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addContstraints()
        setUpHandler()
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
        view.addSubViews(inputSearchView, resultView, noResultView)
        inputSearchView.delegate = self
        resultView.delegate = self
        if let config = viewModel.config {
            topNavBar.detailPageName.text = config.type.title
            inputSearchView.configure(with: SearchInputViewVM(type: config.type))
        }
    }
    
    private func setUpHandler() {
        viewModel.registerOptionChangeBlock { tuple in
            self.inputSearchView.update(option: tuple.0, value: tuple.1)
        }
        
        viewModel.registerSearchResultHandler { [weak self] results in
            DispatchQueue.main.async {
                self?.resultView.configure(with: results)
                self?.noResultView.isHidden = true
                self?.resultView.isHidden = false
            }
        }
        
        viewModel.registerNoResultHandler { [weak self] in
            DispatchQueue.main.async {
                self?.noResultView.isHidden = false
                self?.resultView.isHidden = true
            }
        }
    }
    
    private func addContstraints() {
        NSLayoutConstraint.activate([
            inputSearchView.topAnchor.constraint(equalTo: self.topNavBar.bottomAnchor),
            inputSearchView.leftAnchor.constraint(equalTo: view.leftAnchor),
            inputSearchView.rightAnchor.constraint(equalTo: view.rightAnchor),
            inputSearchView.heightAnchor.constraint(equalToConstant: viewModel.config?.type == .episode ? 55 : 110),
            
            resultView.leftAnchor.constraint(equalTo: view.leftAnchor),
            resultView.rightAnchor.constraint(equalTo: view.rightAnchor),
            resultView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            resultView.topAnchor.constraint(equalTo: inputSearchView.bottomAnchor),
                        
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
        viewModel.executeSearch()
    }
}

// MARK: SearchInputViewDelegate
extension SearchVC: SearchInputViewDelegate {
    func searchInputView(_ inputView: SearchInputView, didSelectOptions option: SearchInputViewVM.DynamicOptions) {
        self.viewModel.goToSearchPicerVC.onNext(option)
    }
    
    func searchInputView(_ inputView: SearchInputView, didChangeSearchText text: String?) {
        guard let text = text else { return }
        viewModel.set(query: text)
    }
    
    func searchInputViewDidTapSearchKeybordBtn(_ inputView: SearchInputView) {
        viewModel.executeSearch()
    }
}

//MARK: SearchResultViewDelegate
extension SearchVC: SearchResultViewDelegate {
    func rmSearchResultView(_ resultView: SearchResultView, didTapLocation locationId: Int) {
        self.viewModel.gotoLocationDetail.onNext("\(locationId)")
    }
    
    func rmSearchResultView(_ resultView: SearchResultView, didTapEpisode episodeId: String) {
        self.viewModel.gotoEpisodeDetail.onNext(episodeId)
    }
    
    func rmSearchResultView(_ resultView: SearchResultView, didTapChracter chracterId: Int) {
        self.viewModel.gotoCharacterDetail.onNext("\(chracterId)")
    }
}
