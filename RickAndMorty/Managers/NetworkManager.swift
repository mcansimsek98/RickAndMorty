//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 28.02.2023.
//

import Foundation
import Moya
import RxSwift
import RxMoya
import UIKit

struct NetworkManager {
    static var shared = NetworkManager()
    private let provider = MoyaProvider<API>()
    
    private init() {}
    
    func request<T: Codable>(_ request: API) -> Observable<T> {
        self.provider.rx.request(request)
            .asObservable().filterSuccessfulStatusCodes().map { (result) in
                return try result.map (T.self)
            }.catch { error in
                return Observable.error(error)
            }
    }
}

extension NetworkManager {
    func getAllCharacter(_ query: String) -> Observable<AllCharactersResponse> {
        NetworkManager.shared.request(.character(query: query))
    }
    
    func getAllEpispde(_ query: String) -> Observable<AllEpisodeResponse> {
        NetworkManager.shared.request(.episode(query: query))
    }
    
    func getCharacterDetail(_ id: String) -> Observable<Character> {
        NetworkManager.shared.request(.characterDetail(id: id))
    }
    
    func getCharacterDetailEpisodes(_ id: String) -> Observable<Episode> {
        NetworkManager.shared.request(.characterDetailEpisode(id: id))
    }
    
    func getAllLocation(_ query: String) -> Observable<AllLocationReponse> {
        NetworkManager.shared.request(.location(query: query))
    }
}
