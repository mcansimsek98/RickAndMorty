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

final class RMCharacterListViewVM : BaseVM {
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

extension RMCharacterListViewVM: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RMCharacterCVCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
}
