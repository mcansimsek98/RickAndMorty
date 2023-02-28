//
//  SplashCoordinator.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 28.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

class SplashCoordinator: ReactiveCoordinator<Void> {
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let vc = SplashVC()
        let vm = SplashVM()
        vc.viewModel = vm
        
        vm.goMain.map { _ in
            self.goToMain()
        }.subscribe().disposed(by: disposeBag)
        
        self.rootViewController.navigationController?.pushViewController(vc, animated: true)
        return Observable.never()
    }
    
    private func goToMain() -> Observable<Void> {
        let coordinator = TabBarCoordinator(rootViewController: self.rootViewController)
        return coordinate(to: coordinator)
    }
}
