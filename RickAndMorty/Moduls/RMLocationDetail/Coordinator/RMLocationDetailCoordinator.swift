//
//  RMLocationDetailCoordinator.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 6.05.2023.
//

import UIKit
import RxSwift
import RxCocoa

class RMLocationDetailCoordinator: ReactiveCoordinator<Void> {
    private let rootViewController: UIViewController
    private let locationId: String
    
    init(rootViewController: UIViewController, locationId: String) {
        self.rootViewController = rootViewController
        self.locationId = locationId
    }
    
    override func start() -> Observable<Void> {
        let vc = RMLocationDetailVC()
        let vm = RMLocationDetailVM()
        vc.viewModel = vm
        vm.locationId = self.locationId

        vm.goToCharacterDetail.subscribe(onNext: { character in
            let _ = RMCharacterDetailCoordinator(rootViewController: self.rootViewController, character: character).start()
        }).disposed(by: disposeBag)

        
        rootViewController.navigationController?.navigationBar.isHidden = true
        rootViewController.navigationController?.pushViewController(vc, animated: true)
        return Observable.never()
    }
}
