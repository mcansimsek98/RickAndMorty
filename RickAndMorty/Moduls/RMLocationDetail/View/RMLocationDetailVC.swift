//
//  RMLocationDetailVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 6.05.2023.
//

import UIKit
import RxSwift

class RMLocationDetailVC: BaseVC<RMLocationDetailVM> {
    private var collectionView: UICollectionView?
    private var cellVM: [SectionTypeOfLocationDetail] = [] {
        didSet {
            self.collectionView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topNavBar.hasBackButton = true
        topNavBar.detailPageName.text = ViewTitle.location
        viewModel.getLocationDetail()
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
            let location = data.location
            let character = data.character
            var createdString = ""
            if let created = Date.dateFormater.date(from: location.created ?? "") {
                createdString = Date.shortDateFormater.string(from: created)
            }
            self.cellVM = [
                .info(viewModel: [
                    .init(title: "Location Name", value: location.name ?? ""),
                    .init(title: "Type", value: location.type ?? ""),
                    .init(title: "Dimension", value: location.dimension ?? ""),
                    .init(title: "Created", value: createdString)
                ]),
                .character(viewModel: character.compactMap({ character in
                    return RMCharacterCVCellVM(
                        characterId: character.id ?? 0,
                        characterName: character.name ?? "",
                        characterStatus: character.status,
                        characterImageUrl: URL(string: character.image ?? ""))
                })),
                .map(viewModel: [
                    .init(title: location.name ?? "")
                ])
            ]
        }).disposed(by: disposeBag)
    }
    

}

extension RMLocationDetailVC {
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
        cv.register(RMLocationInfoCell.self, forCellWithReuseIdentifier: RMLocationInfoCell.cellIdentifier)
        cv.register(RMCharacterCVCell.self, forCellWithReuseIdentifier: RMCharacterCVCell.cellIdentifier)
        cv.register(RMLocationMapCell.self, forCellWithReuseIdentifier: RMLocationMapCell.cellIdentifier)
        return cv
    }
    
    private func layout(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch cellVM[sectionIndex] {
        case .info:
            return viewModel.createInfoSectionLayout()
        case .character:
            return viewModel.createCharacterSectiOnLayout()
        case .map:
            return viewModel.createMapSectionLayout()
        }
    }
}

extension RMLocationDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cellVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellVM[section] {

        case .info(let viewModel):
            return viewModel.count
        case .character(let viewModel):
            return viewModel.count
        case .map:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellVM[indexPath.section] {
        case .info(let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMLocationInfoCell.cellIdentifier , for: indexPath) as! RMLocationInfoCell
            cell.configure(with: cellViewModel)
            return cell
        case .character(let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCVCell.cellIdentifier , for: indexPath) as! RMCharacterCVCell
            cell.configure(with: cellViewModel)
            return cell
        case .map(let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMLocationMapCell.cellIdentifier , for: indexPath) as! RMLocationMapCell
            cell.configure(with: cellViewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch cellVM[indexPath.section] {
        case .info, .map:
            break
        case .character(let viewModel):
            let character = viewModel[indexPath.row].characterId
            self.viewModel.goToCharacterDetail.onNext("\(character)")
        }
    }
}
