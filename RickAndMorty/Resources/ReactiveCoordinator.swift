//
//  ReactiveCoordinator.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import Foundation
import RxSwift

open class ReactiveCoordinator<ResultType> : NSObject {
    public let disposeBag = DisposeBag()
    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()
    
    private func store<T>(coordinator : ReactiveCoordinator<T>){
        childCoordinators[coordinator.identifier] = coordinator
    }
    private func release<T>(coordinator : ReactiveCoordinator<T>){
        childCoordinators[coordinator.identifier] = nil
    }
    open func coordinate<T>(to coordinator : ReactiveCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in
                self?.release(coordinator: coordinator)
            })
    }
    open func start() -> Observable<ResultType> {
        fatalError("Start method must ve implemented.")
    }
}
