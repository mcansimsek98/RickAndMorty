//
//  RMCharacterListView.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 11.03.2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol RMCharacterListViewDelegate: AnyObject {
    func gotoDetailCharacter(_ characterName: String)
}

final class RMCharacterListView: UIView {
    var viewModel: RMCharacterListViewVM?
    private let disposeBag = DisposeBag()
    
    weak var delegate: RMCharacterListViewDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(RMCharacterCVCell.self, forCellWithReuseIdentifier: RMCharacterCVCell.cellIdentifier)
        cv.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let characterDataSource = RxCollectionViewSectionedAnimatedDataSource<DataSourceModel<RMCharacterCVCellVM>> { _, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCVCell.cellIdentifier, for: indexPath) as! RMCharacterCVCell
        cell.configure(with: item)
        return cell
    }
    
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
        ///CollectionViewFooter methods
        characterDataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind ,
                                                                             withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                                                                             for: indexPath) as! RMFooterLoadingCollectionReusableView
            footerView.startAnimating()
            return footerView
        }
        
        ///CollectionViewCellForAtRowandNumberOfRoes methods
        self.viewModel?.allCharacterList.bind(to: collectionView.rx.items(dataSource: self.characterDataSource)).disposed(by: disposeBag)
        
        ///CollectionViewDidSelect method
        Observable
            .zip(collectionView.rx.itemSelected,
                 collectionView.rx.modelSelected(RMCharacterCVCellVM.self))
            .bind { [weak self] indexPath, model in
                self?.delegate?.gotoDetailCharacter("\(model.characterId)")
            }.disposed(by: disposeBag)
        
    }
}

//MARK: CollectionViewLayout guide
extension RMCharacterListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard self.viewModel!.shouldShowLoadMoreIndicator else { return .zero }
        return CGSize(width: collectionView.frame.width, height: 60)
    }
}

//MARK: UIScrollView guide
extension RMCharacterListView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard self.viewModel!.shouldShowLoadMoreIndicator,
              !self.viewModel!.isLoadingMoreCharacters,
              let nextUrlString = self.viewModel?.apiInfo?.next else {
            return
        }
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 50) {
            self.viewModel?.fetchAdditionalCharacter(url: nextUrlString)
        }
    }
}
