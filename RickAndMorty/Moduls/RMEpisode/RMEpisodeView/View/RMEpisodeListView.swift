//
//  RMEpisodeListView.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 2.05.2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol RMEpisodeListViewDelegate: AnyObject {
    func gotoDetailEpisode(_ episode: String)
}

final class RMEpisodeListView: UIView {
    var viewModel: RMEpisodeListViewVM?
    private let disposeBag = DisposeBag()
    
    weak var delegate: RMEpisodeListViewDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(RMEpisodeCVCell.self, forCellWithReuseIdentifier: RMEpisodeCVCell.cellIdentifier)
        cv.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let episodeDataSource = RxCollectionViewSectionedAnimatedDataSource<DataSourceModel<RMEpisodeCVCellVM>> { _, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeCVCell.cellIdentifier, for: indexPath) as! RMEpisodeCVCell
        cell.configureEpisodeCell(with: item)
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
        viewModel = RMEpisodeListViewVM()
        viewModel?.getAllEpisode()
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
        episodeDataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind ,
                                                                             withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                                                                             for: indexPath) as! RMFooterLoadingCollectionReusableView
            footerView.startAnimating()
            return footerView
        }
        
        ///CollectionViewCellForAtRowandNumberOfRoes methods
        self.viewModel?.allEpisodeList.bind(to: collectionView.rx.items(dataSource: self.episodeDataSource)).disposed(by: disposeBag)
        
        ///CollectionViewDidSelect method
        Observable
            .zip(collectionView.rx.itemSelected,
                 collectionView.rx.modelSelected(RMEpisodeCVCellVM.self))
            .bind { [weak self] indexPath, model in
                if let episode = model.episdoeDataURL {
                    if let episodeId = episode.split(separator: "/").last {
                        self?.delegate?.gotoDetailEpisode(String(episodeId))
                    }
                }
            }.disposed(by: disposeBag)
        
    }
}

//MARK: CollectionViewLayout guide
extension RMEpisodeListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width = bounds.width - 20
        return  UIDevice.isiPhone ? CGSize(width: width, height: width * 0.3) : CGSize(width: width, height: width * 0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard self.viewModel!.shouldShowLoadMoreIndicator else { return .zero }
        return CGSize(width: collectionView.frame.width, height: 60)
    }
}

//MARK: UIScrollView guide
extension RMEpisodeListView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard self.viewModel!.shouldShowLoadMoreIndicator,
              !self.viewModel!.isLoadingMoreEpisode,
              let nextUrlString = self.viewModel?.apiInfo?.next else {
            return
        }
//        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 50) {
                self.viewModel?.fetchAdditionalEpisode(url: nextUrlString)
            }
//            t.invalidate()
//        }
    }
}
