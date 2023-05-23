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
    public let gotoLocationDetail = PublishSubject<String>()

    let goToSearchPicerVC = PublishSubject<SearchInputViewVM.DynamicOptions>()
    private var optionMap: [SearchInputViewVM.DynamicOptions: String] = [:]
    private var optionMapUpdateBlock: (((SearchInputViewVM.DynamicOptions, String)) -> Void)?
    private var searchResultHandler: ((SearchResultViewVM) -> Void)?
    private var noResultHandler: (() -> Void)?
    private var searchTetx = ""
    
    public func set(value: String, for option: SearchInputViewVM.DynamicOptions) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((SearchInputViewVM.DynamicOptions, String)) -> Void) {
        self.optionMapUpdateBlock = block
    }
    public func registerSearchResultHandler(_ block: @escaping (SearchResultViewVM) -> Void) {
        self.searchResultHandler = block
    }
    public func registerNoResultHandler(_ block: @escaping () -> Void) {
        self.noResultHandler = block
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
            NetworkManager.shared.searchCharacter(searchTetx, parm: dic).subscribe(onNext: { [weak self] characters in
                guard let self = self else { return }
                self.processSearchResult(model: characters)
            }, onError: { error in
                self.handleNoResult()
            }).disposed(by: disposeBag)
            
        case .episode:
            NetworkManager.shared.searchEpisode(searchTetx, parm: dic).subscribe(onNext: { [weak self] episode in
                guard let self = self else { return }
                self.processSearchResult(model: episode)
            }, onError: { error in
                self.handleNoResult()
            }).disposed(by: disposeBag)
            
        case .location:
            NetworkManager.shared.searchLocation(searchTetx, parm: dic).subscribe(onNext: { [weak self] location in
                guard let self = self else { return }
                self.processSearchResult(model: location)
            }, onError: { error in
                self.handleNoResult()
            }).disposed(by: disposeBag)
        }
    }
    
    private func processSearchResult(model: Codable) {
        var resultVM: SearchResultViewVM?
        if let characterResults = model as? AllCharactersResponse {
            resultVM = .characters(characterResults.results.compactMap({
                return RMCharacterCVCellVM(characterId: $0.id ?? 0,
                                           characterName: $0.name ?? "",
                                           characterStatus: $0.status,
                                           characterImageUrl: URL(string: $0.image ?? ""))
            }))
        } else if let episodeResults = model as? AllEpisodeResponse {
            resultVM = .episode(episodeResults.results.compactMap({
                return RMEpisodeCVCellVM(episdoeDataURL: $0.url)
            }))
        } else if let locationResults = model as? AllLocationReponse {
            resultVM = .locations(locationResults.results.compactMap({
                return LocationTVCellVM(locationId: $0.id ?? 0, location: $0)
            }))
        }
        
        if let results = resultVM {
            self.searchResultHandler?(results)
        }else {
            self.handleNoResult()
        }
    }
    
    private func handleNoResult() {
        self.noResultHandler?()
    }
}
