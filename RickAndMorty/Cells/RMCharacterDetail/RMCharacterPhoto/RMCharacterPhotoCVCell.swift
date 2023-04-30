//
//  RMCharacterPhotoCVCell.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 5.04.2023.
//

import UIKit
import SDWebImage

class RMCharacterPhotoCVCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterPhotoCVCell"
    
    private let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.layer.borderColor = UIColor(named: "BlackColor")?.cgColor
        contentView.layer.shadowColor = UIColor(named: "BlackColor")?.cgColor
        contentView.layer.shadowOffset = CGSize(width: -3, height: 3)
        contentView.layer.shadowOpacity = 0.3
        setUpConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraits() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    public func configurePhotoCell(with viewModel: RMCharacterPhotoCVCellVM) {
        guard let url = viewModel.imageUrl else { return }
        self.imageView.sd_setImage(with: url)
    }
    
}
