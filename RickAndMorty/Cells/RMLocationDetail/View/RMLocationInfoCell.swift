//
//  RMLocationInfoCell.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 7.05.2023.
//

import UIKit

final class RMLocationInfoCell: UICollectionViewCell {
    static let cellIdentifier = "RMLocationInfoCell"
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let valueLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(named: "DarkGrey")
        contentView.addSubViews(titleLabel, valueLabel)
        setUpConstraits()
        setUpLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpLayer() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(named: "BlackColor")?.cgColor
    }
    
    private func setUpConstraits() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.44),
            valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.44),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    func configure(with viewModel: RMLocationInfoCellVM) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
