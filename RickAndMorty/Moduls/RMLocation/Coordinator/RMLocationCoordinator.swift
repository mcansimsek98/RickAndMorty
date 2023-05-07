//
//  RMLocationCoordinator.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

class RMLocationCoordinator: ReactiveCoordinator<Void> {
    private let rootViewController: UIViewController
    private let navigationController: UINavigationController
    
    init(rootViewController: UIViewController, navigationController: UINavigationController) {
        self.rootViewController = rootViewController
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let vc = RMLocationVC()
        let vm = RMLocationVM()
        vc.viewModel = vm
        
        vm.searchAction.subscribe(onNext: { config in
            _ = SearchCoordinator(rootViewController: vc, config: config).start()
        }).disposed(by: disposeBag)
        
        vm.gotoLocationDetail.subscribe(onNext: { locationId in
            _ = RMLocationDetailCoordinator(rootViewController: vc, locationId: locationId).start()
        }).disposed(by: disposeBag)
        
        navigationController.navigationBar.isHidden = true
        navigationController.setViewControllers([vc], animated: true)
        return Observable.never()
    }
}
