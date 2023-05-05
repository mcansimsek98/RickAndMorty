//
//  RMEpisodeDetailCV.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 30.04.2023.
//

import UIKit
import RxSwift

final class RMEpisodeDetailCV: BaseVC<RMEpisodeDetailVM> {
    private var collectionView: UICollectionView?
    private var cellVM: [SectionTypeOfEpisodeDetail] = [] {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topNavBar.hasBackButton = true
        topNavBar.detailPageName.text = "Episode"
        viewModel.getEpisodeDetail()
        bindViewModel()
    }
    
    override func setUpView() {
        self.collectionView = createCharacterCV()
        guard let collectionView = self.collectionView else { return }
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.dataTuple.subscribe(onNext: { data in
            let episode = data.episode
            let character = data.character
            var createdString = ""
            if let created = Date.dateFormater.date(from: episode.created ?? "") {
                createdString = Date.shortDateFormater.string(from: created)
            }
            self.cellVM = [
                .info(viewModel: [
                    .init(title: "Episode Name", value: episode.name),
                    .init(title: "Air Date", value: episode.air_date),
                    .init(title: "Episode", value: episode.episode),
                    .init(title: "Created", value: createdString)
                ]),
                .character(viewModel: character.compactMap({ character in
                    return RMCharacterCVCellVM(
                        characterId: character.id ?? 0,
                        characterName: character.name ?? "",
                        characterStatus: character.status,
                        characterImageUrl: URL(string: character.image ?? ""))
                }))
            ]
        }).disposed(by: disposeBag)
    }
}

extension RMEpisodeDetailCV: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cellVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellVM[section] {
        case .info(let viewModel):
            return viewModel.count
        case .character(let viewModel):
            return viewModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellVM[indexPath.section] {
        case .info(let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeInfoCVCell.cellIdentifier , for: indexPath) as! RMEpisodeInfoCVCell
            cell.configure(with: cellViewModel)
            return cell
        case .character(let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCVCell.cellIdentifier , for: indexPath) as! RMCharacterCVCell
            cell.configure(with: cellViewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch cellVM[indexPath.section] {
        case .info:
            break
        case .character(let viewModel):
            let character = viewModel[indexPath.row].characterId
            self.viewModel.goToCharacterDetail.onNext("\(character)")
        }
    }
}

extension RMEpisodeDetailCV {
    private func createCharacterCV() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.layout(for: section)
        }
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(RMEpisodeInfoCVCell.self, forCellWithReuseIdentifier: RMEpisodeInfoCVCell.cellIdentifier)
        cv.register(RMCharacterCVCell.self, forCellWithReuseIdentifier: RMCharacterCVCell.cellIdentifier)
        return cv
    }
    
    private func layout(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch cellVM[sectionIndex] {
        case .info:
            return viewModel.createInfoSectionLayout()
        case .character:
            return viewModel.createCharacterSectiOnLayout()
        }
    }
}
