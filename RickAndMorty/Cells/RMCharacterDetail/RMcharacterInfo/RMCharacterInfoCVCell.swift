//
//  RMCharacterInfoCVCell.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 5.04.2023.
//

import UIKit

class RMCharacterInfoCVCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterInfoCVCell"
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let iconIV: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleContanierView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "DarkGrey")
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(named: "DarkGrey")?.withAlphaComponent(0.5)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubViews(titleContanierView, valueLabel, iconIV)
        titleContanierView.addSubview(titleLabel)
        setUpConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraits() {
        NSLayoutConstraint.activate([
            titleContanierView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContanierView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContanierView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContanierView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            titleLabel.topAnchor.constraint(equalTo: titleContanierView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: titleContanierView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleContanierView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContanierView.bottomAnchor),
            
            iconIV.heightAnchor.constraint(equalToConstant: 30),
            iconIV.widthAnchor.constraint(equalToConstant: 30),
            iconIV.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            iconIV.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: titleContanierView.topAnchor),
            valueLabel.leftAnchor.constraint(equalTo: iconIV.rightAnchor, constant: 10),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        titleLabel.text = nil
        iconIV.image = nil
        iconIV.tintColor = .label
        titleLabel.textColor = .label
    }
    
    public func configureInfoCell(with viewModel: RMCharacterInfoCVCellVM) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        iconIV.image = viewModel.iconImage
        iconIV.tintColor = viewModel.tintColor
        titleLabel.textColor = viewModel.tintColor
    }
    
}

