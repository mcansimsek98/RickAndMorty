//
//  RMEpisodeListViewVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 2.05.2023.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation

final class RMEpisodeListViewVM : BaseVM {
    public let allEpisodeList = BehaviorSubject(value: [DataSourceModel(header: "", items: [RMEpisodeCVCellVM]())])
    public var apiInfo: AllEpisodeResponse.Info? = nil
    public var isLoadingMoreEpisode: Bool = false
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    private var episodeList: [RMEpisodeCVCellVM] = []
    
    func getAllEpisode(_ query: String = "0") {
        self.showLoading.onNext(true)
        NetworkManager.shared.getAllEpispde(query)
            .map { res -> [RMEpisodeCVCellVM] in
                self.apiInfo = res.info
                return res.results.compactMap { episode in
                    return RMEpisodeCVCellVM(episdoeDataURL: episode.url)
                }
            }
            .subscribe(onNext: { [weak self] viewModel in
                guard let self = self else { return }
                self.showLoading.onNext(false)
                self.episodeList.append(contentsOf: viewModel)
                let data = DataSourceModel(header: "", items: self.episodeList)

                self.allEpisodeList.onNext([data])
                self.isLoadingMoreEpisode = false
            }, onError: { [weak self] error in
                self?.showLoading.onNext(false)
                self?.showFailError(error: error)
            })
            .disposed(by: disposeBag)
    }
    
    public func fetchAdditionalEpisode(url: String) {
        guard !isLoadingMoreEpisode else { return }
        self.isLoadingMoreEpisode = true
        guard let pageNum = getPageNumber(from: url) else {
            self.isLoadingMoreEpisode = false
            return
        }
        self.getAllEpisode(pageNum)
    }
    
    func getPageNumber(from url: String) -> String? {
        guard let urlComponents = URLComponents(string: url) else { return nil }
        guard let pageQueryParam = urlComponents.queryItems?.first(where: { $0.name == "page" }) else { return nil }
        return pageQueryParam.value
    }
    
    
}
