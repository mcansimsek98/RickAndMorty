//
//  RMCharacterListViewVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 13.03.2023.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation

protocol RMCharacterListViewVMDelegate: AnyObject {
    func didLoadInitialCharacter()
}

final class RMCharacterListViewVM : BaseVM {
    public weak var delegate : RMCharacterListViewVMDelegate?

    let allCharacterList = PublishSubject<[RMCharacterCVCellVM]>()

    func getAllCharacter() {
        self.showLoading.onNext(true)
        NetworkManager.shared.getAllCharacter()
            .map { res -> [RMCharacterCVCellVM] in
                return res.results.compactMap { character in
                    guard let imageUrl = URL(string: character.image ?? "") else {
                        return nil
                    }
                    return RMCharacterCVCellVM(
                        characterName: character.name ?? "",
                        characterStatus: character.status,
                        characterImageUrl: imageUrl
                    )
                }
            }
            .subscribe(onNext: { [weak self] viewModel in
                self?.showLoading.onNext(false)
                self?.allCharacterList.onNext(viewModel)
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacter()
                }
            }, onError: { [weak self] error in
                self?.showLoading.onNext(false)
                self?.showFailError(error: error)
            })
            .disposed(by: disposeBag)
    }

    
}
