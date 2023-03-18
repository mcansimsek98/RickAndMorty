//
//  RMCharacterListView.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 11.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class RMCharacterListView: UIView {
    var viewModel: RMCharacterListViewVM?
    private let disposeBag = DisposeBag()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .red
        cv.isHidden = true
        cv.alpha = 0
        cv.register(RMCharacterCVCell.self, forCellWithReuseIdentifier: RMCharacterCVCell.cellIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstraints()
        setUpView()
        bindViewModel()
    }
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    func setUpView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        viewModel = RMCharacterListViewVM()
        viewModel?.delegate = self
        viewModel?.getAllCharacter()
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func addConstraints() {
        addSubViews(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func bindViewModel() {
        self.viewModel?.allCharacterList.bind(to: self.collectionView.rx.items(cellIdentifier: RMCharacterCVCell.cellIdentifier, cellType: RMCharacterCVCell.self)) { row, item, cell in
            cell.configure(with: item)
        }.disposed(by: disposeBag)
    }
}

//MARK: RMCharacterListViewVMDelegate
extension RMCharacterListView: RMCharacterListViewVMDelegate {
    func didLoadInitialCharacter() {
        self.collectionView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1
        }
    }
}

//MARK: CollectionViewLayout guide
extension RMCharacterListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
}
