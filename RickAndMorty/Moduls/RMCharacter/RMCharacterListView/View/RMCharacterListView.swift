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
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 0, right: 10)
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
        viewModel = RMCharacterListViewVM()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    
        addConstraints()
        spinner.startAnimating()
        viewModel?.getAllCharacter()
        setUpCollectionView()
    }
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        addSubViews(collectionView, spinner)
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }
    
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel

        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.spinner.stopAnimating()
            self.collectionView.isHidden = false
            
            UIView.animate(withDuration: 0.3) {
                self.collectionView.alpha = 1
            }
        })
    }
}
