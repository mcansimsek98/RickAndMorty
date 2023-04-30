//
//  BaseVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import UIKit
import RxSwift

class BaseVC<T>: UIViewController where T : BaseVM {
    var viewModel : T!
    let disposeBag = DisposeBag()
    
    let screen = UIScreen.main.bounds
    
    public var topNavBar: TopNavBar = {
        let view = TopNavBar()
        view.layer.borderWidth = 1
        view.backgroundColor = UIColor(named: "TabBarColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.addTopNavBar()
        self.setUpLayer()
        view.backgroundColor = UIColor(named: "Background")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
    func setUpView() {
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
    
    func setUpLayer() {
        topNavBar.layer.borderColor = UIColor(named: "BlackColor")?.withAlphaComponent(0.3).cgColor
        topNavBar.layer.shadowColor = UIColor(named: "BlackColor")?.withAlphaComponent(0.5).cgColor
        topNavBar.layer.shadowOffset = CGSize(width: -3, height: 6)
        topNavBar.layer.shadowOpacity = 0.3
    }
}

extension BaseVC {
    func addTopNavBar() {
        topNavBar.delegate = self
        view.addSubview(topNavBar)
        NSLayoutConstraint.activate([
            topNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  -60),
            topNavBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -2),
            topNavBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  2),
            topNavBar.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}

extension BaseVC: TopNavBarDelegate {
    func backBtnAction() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func shareBtnAction() {
        
    }
}
