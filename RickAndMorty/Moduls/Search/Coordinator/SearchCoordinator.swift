//
//  SearchCoordinator.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 2.05.2023.
//

import UIKit
import RxSwift
import RxCocoa

class SearchCoordinator: ReactiveCoordinator<Void> {
    private let rootViewController: UIViewController
    private let config: Config
    
    init(rootViewController: UIViewController,config: Config) {
        self.rootViewController = rootViewController
        self.config = config
    }
    
    override func start() -> Observable<Void> {
        let vc = SearchVC()
        let vm = SearchVM()
        vc.viewModel = vm
        vm.config = self.config
        
        vm.goToSearchPicerVC.subscribe(onNext: { option in
            _ = RMSearchOptionsPickerCoordinator(rootViewController: self.rootViewController, options: option, selectionBlock: { selection in
                DispatchQueue.main.async {
                    vm.set(value: selection, for: option)
                }
            }).start()
        }).disposed(by: disposeBag)
        
        
        rootViewController.navigationController?.navigationBar.isHidden = true
        rootViewController.navigationController?.pushViewController(vc, animated: true)
        return Observable.never()
    }
}
