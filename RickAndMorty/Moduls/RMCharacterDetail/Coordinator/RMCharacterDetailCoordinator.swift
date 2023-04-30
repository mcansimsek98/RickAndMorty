//
//  RMCharacterDetailCoordinator.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 18.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

class RMCharacterDetailCoordinator: ReactiveCoordinator<Void> {
    private let rootViewController: UIViewController
    private let character: String
    
    init(rootViewController: UIViewController, character: String) {
        self.rootViewController = rootViewController
        self.character = character
    }
    
    override func start() -> Observable<Void> {
        let vc = RMCharacterDetailVC()
        let vm = RMCharacterDetailVM()
        vc.viewModel = vm
        vm.characterId = self.character
        
        vm.goToEpisodeDetail.subscribe(onNext: { episode in
            let _ = RMEpisodeDetailCoordinator(rootViewController: self.rootViewController, episodeId: episode).start()
        }).disposed(by: disposeBag)
        
        rootViewController.navigationController?.navigationBar.isHidden = true
        rootViewController.navigationController?.pushViewController(vc, animated: true)
        return Observable.never()
    }
}
