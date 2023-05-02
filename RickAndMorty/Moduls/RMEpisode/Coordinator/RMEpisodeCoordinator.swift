//
//  RMEpisodeCoordinator.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

class RMEpisodeCoordinator: ReactiveCoordinator<Void> {
    private let rootViewController: UIViewController
    private let navigationController: UINavigationController
    
    init(rootViewController: UIViewController, navigationController: UINavigationController) {
        self.rootViewController = rootViewController
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let vc = RMEpisodeVC()
        let vm = RMEpisodeVM()
        vc.viewModel = vm
        
        vm.gotoDetailEpisode.subscribe(onNext: { episode in
            let _ = RMEpisodeDetailCoordinator(rootViewController: vc, episodeId: episode).start()
        }).disposed(by: disposeBag)
        
        vm.searchAction.subscribe(onNext: { config in
            _ = SearchCoordinator(rootViewController: vc, config: config).start()
        }).disposed(by: disposeBag)
        
        navigationController.navigationBar.isHidden = true
        navigationController.setViewControllers([vc], animated: true)
        return Observable.never()
    }
}
