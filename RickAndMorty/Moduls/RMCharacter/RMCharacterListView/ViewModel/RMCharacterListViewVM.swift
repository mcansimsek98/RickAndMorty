//
//  RMCharacterListViewVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 13.03.2023.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation

final class RMCharacterListViewVM : BaseVM {
    public let allCharacterList = BehaviorSubject(value: [DataSourceModel(header: "", items: [RMCharacterCVCellVM]())])
    public var apiInfo: AllCharactersResponse.Info? = nil
    public var isLoadingMoreCharacters: Bool = false
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    private var characterList: [RMCharacterCVCellVM] = []
    
    func getAllCharacter(_ query: String = "0") {
        self.showLoading.onNext(true)
        NetworkManager.shared.getAllCharacter(query)
            .map { res -> [RMCharacterCVCellVM] in
                self.apiInfo = res.info
                return res.results.compactMap { character in
                    guard let imageUrl = URL(string: character.image ?? "") else {
                        return nil
                    }
                    return RMCharacterCVCellVM(
                        characterId: character.id ?? 0,
                        characterName: character.name ?? "",
                        characterStatus: character.status,
                        characterImageUrl: imageUrl
                    )
                }
            }
            .subscribe(onNext: { [weak self] viewModel in
                guard let self = self else { return }
                self.showLoading.onNext(false)
                self.characterList.append(contentsOf: viewModel)
                let data = DataSourceModel(header: "", items: self.characterList)

                self.allCharacterList.onNext([data])
                self.isLoadingMoreCharacters = false
            }, onError: { [weak self] error in
                self?.showLoading.onNext(false)
                self?.showFailError(error: error)
            })
            .disposed(by: disposeBag)
    }
    
    public func fetchAdditionalCharacter(url: String) {
        guard !isLoadingMoreCharacters else { return }
        self.isLoadingMoreCharacters = true
        guard let pageNum = getPageNumber(from: url) else {
            self.isLoadingMoreCharacters = false
            return
        }
        self.getAllCharacter(pageNum)
    }
    
    func getPageNumber(from url: String) -> String? {
        guard let urlComponents = URLComponents(string: url) else { return nil }
        guard let pageQueryParam = urlComponents.queryItems?.first(where: { $0.name == "page" }) else { return nil }
        return pageQueryParam.value
    }
}
