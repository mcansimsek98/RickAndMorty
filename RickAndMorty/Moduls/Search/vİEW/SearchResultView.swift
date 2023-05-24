//
//  SearchResultView.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 23.05.2023.
//

import UIKit
import Differentiator

protocol SearchResultViewDelegate: AnyObject {
    func rmSearchResultView(_ resultView: SearchResultView, didTapLocation locationId: Int)
    func rmSearchResultView(_ resultView: SearchResultView, didTapEpisode episodeId: String)
    func rmSearchResultView(_ resultView: SearchResultView, didTapChracter chracterId: Int)
    
}

final class SearchResultView: UIView {
    weak var delegate: SearchResultViewDelegate?
    
    private var locationCellVM: [LocationTVCellVM] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private var collectionViewCellVM: [any IdentifiableType] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private var viewModel: SearchResultViewVM? {
        didSet {
            self.processVM()
        }
    }
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(LocationTVCell.self, forCellReuseIdentifier: LocationTVCell.identifier)
        tv.backgroundColor = .clear
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.isHidden = true
        return tv
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(RMCharacterCVCell.self, forCellWithReuseIdentifier: RMCharacterCVCell.cellIdentifier)
        cv.register(RMEpisodeCVCell.self, forCellWithReuseIdentifier: RMEpisodeCVCell.cellIdentifier)
        cv.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.isHidden = true
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
        addSubViews(tableView, collectionView)
        addConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: funcs
    private func processVM() {
        guard let viewModel = viewModel else { return }
        switch viewModel {
        case .characters(let viewModel):
            setUpCollectionView(viewModels: viewModel)
        case .episode(let viewModel):
            setUpCollectionView(viewModels: viewModel)
        case .locations(let viewModel):
            setUpTableView(viewModels: viewModel)
        }
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setUpTableView(viewModels: [LocationTVCellVM]) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        collectionView.isHidden = true
        locationCellVM = viewModels
    }
    
    private func setUpCollectionView(viewModels: [any IdentifiableType]) {
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.isHidden = true
        collectionView.isHidden = false
        self.collectionViewCellVM = viewModels
    }
    
    public func configure(with viewModel: SearchResultViewVM) {
        self.viewModel = viewModel
    }
}

//
//MARK: UITableViewDelegate
extension SearchResultView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationCellVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTVCell.identifier, for: indexPath) as? LocationTVCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = UIColor(named: "DarkGrey")?.withAlphaComponent(0.5)
        cell.configure(with: locationCellVM[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewModel = locationCellVM[indexPath.row]
        self.delegate?.rmSearchResultView(self, didTapLocation: viewModel.locationId)
    }
}



//MARK: CollectionViewLayout guide
extension SearchResultView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCellVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentVM = collectionViewCellVM[indexPath.row]
        if let characterVM = currentVM as? RMCharacterCVCellVM {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCVCell.cellIdentifier, for: indexPath) as? RMCharacterCVCell else { fatalError() }
            cell.configure(with: characterVM)
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeCVCell.cellIdentifier, for: indexPath) as? RMEpisodeCVCell else { fatalError() }
        guard let episodeVM = currentVM as? RMEpisodeCVCellVM else { fatalError() }
        cell.configureEpisodeCell(with: episodeVM)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        
        let currentVM = collectionViewCellVM[indexPath.row]
        if let characterVM = currentVM as? RMCharacterCVCellVM {
            self.delegate?.rmSearchResultView(self, didTapChracter: characterVM.characterId)
        } else if let episodeVM = currentVM as? RMEpisodeCVCellVM {
            if let episode = episodeVM.episdoeDataURL {
                if let episodeId = episode.split(separator: "/").last {
                    self.delegate?.rmSearchResultView(self, didTapEpisode: "\(episodeId)")
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let currentVM = collectionViewCellVM[indexPath.row]
        let bounds = collectionView.bounds
        var width: CGFloat
        if currentVM is RMCharacterCVCellVM {
            width = UIDevice.isiPhone ? (bounds.width-30) / 2 : (bounds.width-50) / 4
            return CGSize(width: width, height: width * 1.5)
        }
        
        width = UIDevice.isiPhone ? bounds.width - 20 : (bounds.width-30) / 2
        return UIDevice.isiPhone ? CGSize(width: width, height: width * 0.3) : CGSize(width: width, height: width * 0.13)
    }
}
