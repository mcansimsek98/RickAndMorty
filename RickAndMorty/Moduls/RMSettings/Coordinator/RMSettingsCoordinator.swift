//
//  RMSettingsCoordinator.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

class RMSettingsCoordinator: ReactiveCoordinator<Void> {
    private let rootViewController: UIViewController
    private let navigationController: UINavigationController
    
    init(rootViewController: UIViewController, navigationController: UINavigationController) {
        self.rootViewController = rootViewController
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let vc = RMSettingsVC()
        let vm = RMSettingsVM()
        vc.viewModel = vm
        
        navigationController.navigationBar.isHidden = true
        navigationController.setViewControllers([vc], animated: true)
        return Observable.never()
    }
}
