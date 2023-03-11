//
//  RMCharacterVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import Foundation
import RxSwift

class RMCharacterVM: BaseVM {
    
    let allCharacterList = PublishSubject<AllCharactersResponse>()
    
    func getAllCharacter() {
        self.showLoading.onNext(true)
        NetworkManager.shared.getAllCharacter().subscribe(onNext: { res in
            self.showLoading.onNext(false)
            self.allCharacterList.onNext(res)
        }, onError: { error in
            self.showLoading.onNext(false)
            self.showFailError(error: error)
        }).disposed(by: disposeBag)
    }
    
}
