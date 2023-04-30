//
//  RMCharacterDetailVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 18.03.2023.
//

import UIKit
import RxSwift

final class RMCharacterDetailVC: BaseVC<RMCharacterDetailVM> {
    
    private var collectionView: UICollectionView?
    var sections: [SectionType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        topNavBar.hasBackButton = true
        viewModel.getCharacterDetail()
    }
    
    override func setUpView() {
        self.collectionView = createCharacterCV()
        guard let collectionView = self.collectionView else { return }
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func bindViewModel() {
        viewModel.character.subscribe(onNext: { character in
            self.topNavBar.detailPageName.text = character.name
            self.sections = [
                .photo(viewModel: .init(imageUrl: URL(string: character.image ?? ""))),
                .info(viewModel: [
                    .init(type: .status ,value: character.status.text),
                    .init(type: .gender,value: character.gender.rawValue),
                    .init(type: .type ,value: character.type ?? ""),
                    .init(type: .species ,value: character.species ?? ""),
                    .init(type: .orgin ,value: character.origin.name ?? ""),
                    .init(type: .location ,value: character.location.name ?? ""),
                    .init(type: .created ,value: character.created ?? ""),
                    .init(type: .episodeCount ,value: "\(character.episode.count)")
                ]),
                .episodes(viewModel: character.episode.compactMap ({
                    return RMCharacterEpisodeCVCellVM(episdoeDataURL: $0)
                }))
            ]
            self.collectionView?.reloadData()
        }).disposed(by: disposeBag)
    }
    
}

extension RMCharacterDetailVC {
    private func createCharacterCV() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(RMCharacterPhotoCVCell.self, forCellWithReuseIdentifier: RMCharacterPhotoCVCell.cellIdentifier)
        cv.register(RMCharacterInfoCVCell.self, forCellWithReuseIdentifier: RMCharacterInfoCVCell.cellIdentifier)
        cv.register(RMCharacterEpisodeCVCell.self, forCellWithReuseIdentifier: RMCharacterEpisodeCVCell.cellIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch sections[sectionIndex] {
        case .photo:
            return viewModel.createPhotoSectipnLayout()
        case .info:
            return viewModel.createInfoSectipnLayout()
        case .episodes:
            return viewModel.createEpisodesSectipnLayout()
        }
    }
}

extension RMCharacterDetailVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .photo:
            return 1
        case .info(let viewModel):
            return viewModel.count
        case .episodes(let viewModel):
            return viewModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .photo(let viewModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCVCell.cellIdentifier, for: indexPath) as! RMCharacterPhotoCVCell
            cell.configurePhotoCell(with: viewModel)
            return cell
        case .info(let viewModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInfoCVCell.cellIdentifier, for: indexPath) as! RMCharacterInfoCVCell
            cell.configureInfoCell(with: viewModel[indexPath.row])
            return cell
        case .episodes(let viewModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCVCell.cellIdentifier, for: indexPath) as! RMCharacterEpisodeCVCell
            cell.configureEpisodeCell(with: viewModel[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .photo, .info:
            break
        case .episodes:
            guard let episodes = self.viewModel.characterList?.episode else { return }
            let selection = episodes[indexPath.row]
            if let episodeId = selection.split(separator: "/").last {
                self.viewModel.goToEpisodeDetail.onNext(String(episodeId))
            }
        }
    }
}
