//
//  RMSearchOptionsPickerCoordinator.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 21.05.2023.
//
import UIKit
import RxSwift
import RxCocoa

class RMSearchOptionsPickerCoordinator: ReactiveCoordinator<Void> {
    private let rootViewController: UIViewController
    private let options: SearchInputViewVM.DynamicOptions
    private let selectionBlock: ((String) -> Void)

    init(rootViewController: UIViewController, options: SearchInputViewVM.DynamicOptions, selectionBlock: @escaping ((String) -> Void)) {
        self.rootViewController = rootViewController
        self.options = options
        self.selectionBlock = selectionBlock
    }
    
    override func start() -> Observable<Void> {
        let vc = RMSearchOptionsPickerVC()
        let vm = RMSearchOptionsPickerVM()
        vc.viewModel = vm
        vc.selectionBlock = self.selectionBlock
        vc.options = self.options
        
        rootViewController.navigationController?.navigationBar.isHidden = true
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        rootViewController.navigationController?.present(vc, animated: true)
        return Observable.never()
    }
}
