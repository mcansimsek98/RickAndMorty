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
        let navBarAppearance = UINavigationBarAppearance()
        let backgroundImage = UIImage(named: "rick")
        navBarAppearance.backgroundImage = backgroundImage
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor(named: "BlueColor")
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "Background")
    }
    
    func setUpConstraints() {
    }
}
