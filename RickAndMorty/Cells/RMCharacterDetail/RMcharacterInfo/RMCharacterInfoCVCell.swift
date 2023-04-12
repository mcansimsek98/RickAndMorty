//
//  RMCharacterInfoCVCell.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 5.04.2023.
//

import UIKit

class RMCharacterInfoCVCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterInfoCVCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraits() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configureInfoCell(with viewModel: RMCharacterInfoCVCellVM) {
        
    }
    
}

