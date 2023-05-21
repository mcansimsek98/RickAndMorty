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
    func shareBtnAction()
}

protocol TopNavBarSearchDetailDelegate: AnyObject {
    func searchBtnAction()
}

@IBDesignable
class TopNavBar: UIView {
    
    @IBInspectable var hasBackButton:Bool = false {
        didSet {
            backBtn.isHidden = !hasBackButton
            shareBtn.isHidden = !hasBackButton
            detailPageName.isHidden = !hasBackButton
            title.isHidden = hasBackButton
            searchBtn.isHidden = hasBackButton
            searchDetailBtn.isHidden = !hasBackButton
        }
    }
    
    @IBInspectable var hasSearchDetailButton:Bool = false {
        didSet {
            searchDetailBtn.isHidden = !hasSearchDetailButton
        }
    }
    
    private lazy var backBtn: UIButton = {
        let button = UIButton(frame: .zero)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        return button
    }()
    
    public lazy var shareBtn: UIButton = {
        let button = UIButton(frame: .zero)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "shareBtn"), for: .normal)
        return button
    }()
    
    public lazy var searchBtn: UIButton = {
        let button = UIButton(frame: .zero)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Search"), for: .normal)
        return button
    }()
    
    public lazy var searchDetailBtn: UIButton = {
        let button = UIButton(frame: .zero)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.setTitleColor(UIColor(named: "BlackColor"), for: .normal)
        return button
    }()
    
    public var detailPageName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE", size: 22)
        label.textColor = UIColor(named: "BlackColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Chalkboard SE", size: 30)
        label.textColor = UIColor(named: "BlackColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    weak  var delegate: TopNavBarDelegate?
    weak var searchDelegate: TopNavBarSearchDetailDelegate?
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
        addSubViews(title, backBtn, detailPageName, shareBtn, searchBtn, searchDetailBtn)
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            title.heightAnchor.constraint(equalToConstant: 42),
            
            backBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            backBtn.heightAnchor.constraint(equalToConstant: 24),
            backBtn.widthAnchor.constraint(equalToConstant: 24),
            
            shareBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            shareBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            shareBtn.heightAnchor.constraint(equalToConstant: 24),
            shareBtn.widthAnchor.constraint(equalToConstant: 24),
            
            searchBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            searchBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            searchBtn.heightAnchor.constraint(equalToConstant: 44),
            searchBtn.widthAnchor.constraint(equalToConstant: 44),
            
            searchDetailBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            searchDetailBtn.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchDetailBtn.heightAnchor.constraint(equalToConstant: 42),
            
            detailPageName.centerXAnchor.constraint(equalTo: centerXAnchor),
            detailPageName.centerYAnchor.constraint(equalTo: self.backBtn.centerYAnchor, constant: -2),
            detailPageName.heightAnchor.constraint(equalToConstant: 30),
            detailPageName.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
}

extension TopNavBar {
    func configure() {        
        self.backBtn.rx.tap.bind {
            self.delegate?.backBtnAction()
        }.disposed(by: disposeBag)
        
        self.shareBtn.rx.tap.bind {
            self.delegate?.shareBtnAction()
        }.disposed(by: disposeBag)
        
        self.searchDetailBtn.rx.tap.bind {
            self.searchDelegate?.searchBtnAction()
        }.disposed(by: disposeBag)
    }
}
