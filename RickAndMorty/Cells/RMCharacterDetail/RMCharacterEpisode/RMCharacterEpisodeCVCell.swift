//
//  RMCharacterEpisodeCVCell.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 5.04.2023.
//

import UIKit

class RMCharacterEpisodeCVCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterEpisodeCVCell"
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(named: "DarkGrey")?.withAlphaComponent(0.7)
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.4).cgColor
        contentView.layer.borderWidth = 1
        contentView.addSubViews(seasonLabel, nameLabel, airDateLabel)
        setUpConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraits() {
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 4),
            seasonLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            seasonLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            airDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
    }
    
    public func configureEpisodeCell(with viewModel: RMCharacterEpisodeCVCellVM) {
        viewModel.registerForData { [weak self] data in
            DispatchQueue.main.async {
                self?.nameLabel.text = data.name
                self?.seasonLabel.text = "Episode " + data.episode
                self?.airDateLabel.text = "Aired on " + data.air_date
            }
        }
        viewModel.fetchEpisode()
    }
    
}
