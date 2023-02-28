//
//  TabBarCoordinator.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TabBarCoordinator: ReactiveCoordinator<Void> {
    private let rootViewController: UIViewController
    private var navigationControllers: [UINavigationController]
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        self.navigationControllers = TabBarKind.items
            .map({ (item) -> UINavigationController in
                return item.navigationController
            })
    }
    
    override func start() -> Observable<Void> {
        
        let vc = TabBarVC()
        vc.tabBar.isTranslucent = false
        vc.viewControllers = navigationControllers
        
        let coordinates = navigationControllers.enumerated()
            .map { (offset, element) -> Observable<Void> in
                guard let items = TabBarKind(rawValue: offset) else { return Observable.just(() )}
                switch items {
                case .characters:
                    return coordinate(to: RMCharacterCoordinator(rootViewController: self.rootViewController, navigationController: element))
                case .locations:
                    return coordinate(to: RMLocationCoordinator(rootViewController: self.rootViewController, navigationController: element))
                case .sections:
                    return coordinate(to: RMEpisodeCoordinator(rootViewController: self.rootViewController, navigationController: element))
                case .settings:
                    return coordinate(to: RMSettingsCoordinator(rootViewController: self.rootViewController, navigationController: element))
                }
            }

        Observable.merge(coordinates)
            .subscribe()
            .disposed(by: disposeBag)
        
        rootViewController.navigationController!.setNavigationBarHidden(true, animated: true)
        rootViewController.navigationController?.pushViewController(vc, animated: false)
        return  Observable.never()
    }
}
