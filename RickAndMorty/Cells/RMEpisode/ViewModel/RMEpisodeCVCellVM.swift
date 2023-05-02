//
//  RMCharacterEpisodeVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 5.04.2023.
//

import Foundation
import RxSwift
import RxDataSources

protocol RMEpisodeDataRender  {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}

final class RMEpisodeCVCellVM: BaseVM, IdentifiableType {
    var identity: String {
        return self.episdoeDataURL ?? ""
    }
    let episdoeDataURL: String?
    private var isFetching = false
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    private var episode: Episode? {
        didSet {
            guard let model = episode else { return }
            self.dataBlock?(model)
        }
    }
    
    init(episdoeDataURL: String?) {
        self.episdoeDataURL = episdoeDataURL
    }
    
    public func registerForData(_ block: @escaping (RMEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                self.dataBlock?(model)
            }
            return
        }
        self.showLoading.onNext(true)
        self.isFetching = true
        if let episodeId = episdoeDataURL?.split(separator: "/").last {
            NetworkManager.shared.getCharacterDetailEpisodes("\(episodeId)").subscribe(onNext: { [weak self] episode in
                self?.showLoading.onNext(false)
                DispatchQueue.main.async {
                    self?.episode = episode
                }
            }, onError: { error in
                self.showLoading.onNext(false)
                self.showFailError(error: error)
            }).disposed(by: disposeBag)
        }
    }
}
