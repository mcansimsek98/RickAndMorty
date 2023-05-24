//
//  RMEpisodeDetailVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 30.04.2023.
//

import UIKit
import RxSwift

enum SectionTypeOfEpisodeDetail {
    case info(viewModel: [RMEpisodeInfoCVCellVM])
    case character(viewModel: [RMCharacterCVCellVM])
}

class RMEpisodeDetailVM: BaseVM {
    var episodeId: String = ""
    let episodeDetail = PublishSubject<Episode>()
    let goToCharacterDetail = PublishSubject<String>()
    let dataTuple = PublishSubject<(episode: Episode, character: [Character])>()

    func getEpisodeDetail() {
        NetworkManager.shared.getCharacterDetailEpisodes("\(episodeId)").subscribe(onNext: { [weak self] episode in
            self?.showLoading.onNext(false)
            self?.fetchRelatedCharacters(episode: episode)
            self?.episodeDetail.onNext(episode)
        }, onError: { error in
            self.showLoading.onNext(false)
            self.showFailError(error: error)
        }).disposed(by: disposeBag)
    }
    
    private func fetchRelatedCharacters(episode: Episode) {
        let characterId: [String] = episode.characters.compactMap({
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
            self.dataTuple.onNext((episode,characters))
        }
    }
}

extension RMEpisodeDetailVM {
    func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createCharacterSectiOnLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(UIDevice.isiPhone ? 0.5 : 0.25), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(UIDevice.isiPhone ? 260 : 320)), subitems: UIDevice.isiPhone ? [item, item] : [item, item, item, item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
