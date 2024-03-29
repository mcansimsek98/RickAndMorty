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
    
    func getLocationDetail(_ id: String) -> Observable<Location> {
        NetworkManager.shared.request(.locationDetail(id: id))
    }
    
    func searchCharacter(_ query: String, parm: [String : String]) -> Observable<AllCharactersResponse> {
        NetworkManager.shared.request(.searchCharacter(query: query, parm: parm))
    }
    func searchLocation(_ query: String, parm: [String : String]) -> Observable<AllLocationReponse> {
        NetworkManager.shared.request(.searchlocation(query: query, parm: parm))
    }
    func searchEpisode(_ query: String, parm: [String: String]) -> Observable<AllEpisodeResponse> {
        NetworkManager.shared.request(.searchEpisode(query: query, parm: parm))
    }
    
}
