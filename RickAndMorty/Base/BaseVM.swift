//
//  BaseVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import Foundation
import RxSwift
import Moya

class BaseVM {
    let showLoading = BehaviorSubject<Bool>(value: false)
    var error = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    func showFailError(error: Error) {
        do {
            let errorRes = error as? Moya.MoyaError
            if let body = try errorRes?.response?.mapJSON() {
                let errorStr = ((body as! [String: Any])["errors"] as? [String])?.first
                self.error.onNext(errorStr ?? "Bilinmeyen bir hata oluştu. Daha sonra tekrar deneyin!.")
                return
            }
            if errorRes?.response?.statusCode ?? 200 >= 500 {
                self.error.onNext("İşlem başarısız. Bilinmeyen bir hata oluştu.")
            }
        } catch {
            print(error)
        }
    }
}
