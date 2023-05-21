//
//  RMLocationDetailVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 6.05.2023.
//

import UIKit
import RxSwift

enum SectionTypeOfLocationDetail {
    case info(viewModel: [RMLocationInfoCellVM])
    case character(viewModel: [RMCharacterCVCellVM])
    case map(viewModel: [RMLocationMapCellVM])
}

final class RMLocationDetailVM: BaseVM {
    let goToCharacterDetail = PublishSubject<String>()
    public var locationId: String = ""
    let dataTuple = PublishSubject<(location: Location, character: [Character])>()
    let location = PublishSubject<Location>()
    
    func getLocationDetail() {
        NetworkManager.shared.getLocationDetail(locationId).subscribe(onNext: { [weak self] location in
            self?.showLoading.onNext(false)
            self?.location.onNext(location)
            self?.fetchRelatedCharacters(location: location)
        }, onError: { error in
            self.showLoading.onNext(false)
            self.showFailError(error: error)
        }).disposed(by: disposeBag)
    }
    
    private func fetchRelatedCharacters(location: Location) {
        let characterId: [String] = location.residents.compactMap({
            return String($0.split(separator: "/").last ?? "")
        })
        let group = DispatchGroup()
        var characters: [Character] = []
        for id in characterId {
            group.enter()
            self.showLoading.onNext(true)
            NetworkManager.shared.getCharacterDetail(id).subscribe(onNext: { character in
                self.showLoading.onNext(false)
                defer {
                    group .leave()
                }
                characters.append(character)
            }, onError: { error in
                self.showLoading.onNext(false)
                self.showFailError(error: error)
            }).disposed(by: disposeBag)
        }
        group.notify(queue: .main) {
            self.dataTuple.onNext((location,characters))
        }
    }
    
}

extension RMLocationDetailVM {
    func createMapSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(320)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createCharacterSectiOnLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(260)), subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
