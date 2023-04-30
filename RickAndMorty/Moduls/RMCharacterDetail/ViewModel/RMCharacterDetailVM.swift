//
//  RMCharacterDetailVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 18.03.2023.
//

import UIKit
import RxSwift

enum SectionType {
    case photo(viewModel: RMCharacterPhotoCVCellVM)
    case info(viewModel: [RMCharacterInfoCVCellVM])
    case episodes(viewModel: [RMCharacterEpisodeCVCellVM])
}

final class RMCharacterDetailVM: BaseVM {
    let character = PublishSubject<Character>()
    let goToEpisodeDetail = PublishSubject<String>()
    var characterId: String = ""
    var characterList: Character?
    
    func getCharacterDetail() {
        self.showLoading.onNext(true)
        NetworkManager.shared.getCharacterDetail(characterId)
            .subscribe(onNext: { [weak self] character in
                self?.characterList = character
                self?.character.onNext(character)
            }, onError: { [weak self] error in
                self?.showLoading.onNext(false)
                self?.showFailError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func createPhotoSectipnLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 8, trailing: 2)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createInfoSectipnLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)), subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createEpisodesSectipnLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(150)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
