//
//  SearchView.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 21.05.2023.
//

import UIKit

final class SearchView: UIView {
    private let viewModel = SearchViewVM()
    private let noResultView = RMNoSearchResulView()
    
//    private let searchCV: UICollectionView = {
//        let cv = UICollectionView()
//        return cv
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(noResultView)
        addContstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addContstraints() {
        NSLayoutConstraint.activate([
            noResultView.widthAnchor.constraint(equalToConstant: 150),
            noResultView.heightAnchor.constraint(equalToConstant: 150),
            noResultView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}

//extension SearchView: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RMEpisodeInfoCVCell", for: indexPath) as! RMEpisodeInfoCVCell
//
//        return cell
//    }
//}
