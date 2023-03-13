//
//  TopNavBar.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 13.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

protocol TopNavBarDelegate: AnyObject {
    func backBtnAction()
}

@IBDesignable
class TopNavBar: UIView {
    
    @IBInspectable var hasBackButton:Bool = false {
        didSet {
            backBtn.isHidden = !hasBackButton
            detailPageName.isHidden = !hasBackButton
            title.isHidden = hasBackButton
            iconImageView.isHidden = hasBackButton
        }
    }
    
    private lazy var backBtn: UIButton = {
        let button = UIButton(frame: .zero)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        return button
    }()
    
    private var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "rickandmortyicons")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let detailPageName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = UIColor(named: "BlackColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Chalkboard SE", size: 30)
        label.textColor = UIColor(named: "BlackColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    weak  var delegate: TopNavBarDelegate?
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init() {
        super.init(frame: .zero)
        layout()
        configure()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }

    private func layout() {
        addSubViews(title, backBtn, detailPageName, iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            iconImageView.heightAnchor.constraint(equalToConstant: 65),
            iconImageView.widthAnchor.constraint(equalToConstant: 125),
            
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            title.heightAnchor.constraint(equalToConstant: 42),
            
            backBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            backBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            backBtn.heightAnchor.constraint(equalToConstant: 24),
            backBtn.widthAnchor.constraint(equalToConstant: 24),
            
            detailPageName.leadingAnchor.constraint(equalTo: self.backBtn.trailingAnchor, constant: 10),
            detailPageName.bottomAnchor.constraint(equalTo: self.backBtn.bottomAnchor),
            detailPageName.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
}

extension TopNavBar {
    func configure() {        
        self.backBtn.rx.tap.bind {
            self.delegate?.backBtnAction()
        }.disposed(by: disposeBag)
    }
}
