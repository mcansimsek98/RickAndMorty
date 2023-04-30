//
//  RMEpisodeDetailCoordinator.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 30.04.2023.
//

import UIKit
import RxSwift
import RxCocoa

class RMEpisodeDetailCoordinator: ReactiveCoordinator<Void> {
    private let rootViewController: UIViewController
    private let episodeId: String
    
    init(rootViewController: UIViewController, episodeId: String) {
        self.rootViewController = rootViewController
        self.episodeId = episodeId
    }
    
    override func start() -> Observable<Void> {
        let vc = RMEpisodeDetailCV()
        let vm = RMEpisodeDetailVM()
        vc.viewModel = vm
        vm.episodeId = self.episodeId
        
        rootViewController.navigationController?.navigationBar.isHidden = true
        rootViewController.navigationController?.pushViewController(vc, animated: true)
        return Observable.never()
    }
}
