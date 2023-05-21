//
//  RMNoSearchResulView.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 21.05.2023.
//

import UIKit

final class RMNoSearchResulView: UIView {
    private let viewModel = RMNoSearchResulViewVM()
    
    private let iconView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemBlue
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLbl : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20, weight: .medium)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(iconView, titleLbl)
        addConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        self.iconView.image = viewModel.image
        self.titleLbl.text = viewModel.title
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 90),
            iconView.heightAnchor.constraint(equalToConstant: 90),
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLbl.leftAnchor.constraint(equalTo: leftAnchor),
            titleLbl.rightAnchor.constraint(equalTo: rightAnchor),
            titleLbl.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLbl.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
        ])
    }
}
