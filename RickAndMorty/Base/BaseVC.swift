//
//  BaseVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import UIKit
import RxSwift

class BaseVC<T>: UIViewController where T : BaseVM {
    var viewModel : T?
    let disposeBag = DisposeBag()
    
    let screen = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.setUpView()
        self.setUpConstraints()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
    func configure() {
    }
    
    func setUpView() {
        navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }
    
    func setUpConstraints() {
    }
}
