//
//  SearchVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 2.05.2023.
//

import Foundation
import RxSwift

final class SearchVM: BaseVM {
    var config: Config?
    
    let goToSearchPicerVC = PublishSubject<SearchInputViewVM.DynamicOptions>()
    private var optionMap: [SearchInputViewVM.DynamicOptions: String] = [:]
    private var optionMapUpdateBlock: (((SearchInputViewVM.DynamicOptions, String)) -> Void)?
    private var searchResultHandler: (() -> Void)?
    private var searchTetx = ""
    
    public func set(value: String, for option: SearchInputViewVM.DynamicOptions) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((SearchInputViewVM.DynamicOptions, String)) -> Void) {
        self.optionMapUpdateBlock = block
    }
    
    public func registerSearchResultHandler(_ block: @escaping () -> Void) {
        self.searchResultHandler = block
    }
    
    public func set(query text: String) {
        self.searchTetx = text
    }
    
    public func executeSearch() {
        guard let config = config else { return }
        guard !searchTetx.isEmpty else { return }
        var dic : [String: String] = [:]
        for (option, value) in optionMap {
            dic[option.queryArgument] = value
        }
        
        switch config.type {
        case .character:
            NetworkManager.shared.searchCharacter(searchTetx, parm: dic).subscribe(onNext: { [weak self] character in
                guard let self = self else { return }
                print("character", character.results.count)
            }, onError: { error in
                self.showFailError(error: error)
            }).disposed(by: disposeBag)
            
        case .episode:
            NetworkManager.shared.searchEpisode(searchTetx, parm: dic).subscribe(onNext: { [weak self] episode in
                guard let self = self else { return }
                print("episode", episode.results.count)
            }, onError: { error in
                self.showFailError(error: error)
            }).disposed(by: disposeBag)
            
        case .location:
            NetworkManager.shared.searchLocation(searchTetx, parm: dic).subscribe(onNext: { [weak self] location in
                guard let self = self else { return }
                print("location", location.results.count)
            }, onError: { error in
                self.showFailError(error: error)
            }).disposed(by: disposeBag)
        }
    }
}
