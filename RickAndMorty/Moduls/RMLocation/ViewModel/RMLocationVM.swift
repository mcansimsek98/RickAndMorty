//
//  RMLocationVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class RMLocationVM: BaseVM {
    public let gotoLocationDetail = PublishSubject<String>()
    public let searchAction = PublishSubject<Config>()
    public let allLocationList = BehaviorSubject(value: [DataSourceModel(header: "", items: [LocationTVCellVM]())])
    public var apiInfo: AllLocationReponse.Info? = nil
    public var isLoadingMoreLocation: Bool = false
    public var hasMoreResults: Bool {
        return apiInfo?.next != nil
    }
    
    private var locationList: [LocationTVCellVM] = []

    func getAllLocation(_ query: String = "0") {
        self.showLoading.onNext(true)
        NetworkManager.shared.getAllLocation(query)
            .map { res -> [LocationTVCellVM] in
                self.apiInfo = res.info
                return res.results.compactMap { location in
                    return LocationTVCellVM(locationId: location.id ?? 0, location: location)
                }
            }
            .subscribe(onNext: { [weak self] viewModel in
                guard let self = self else { return }
                self.showLoading.onNext(false)
                self.locationList.append(contentsOf: viewModel)
                let data = DataSourceModel(header: "", items: self.locationList)

                self.allLocationList.onNext([data])
                self.isLoadingMoreLocation = false
            }, onError: { [weak self] error in
                self?.showLoading.onNext(false)
                self?.showFailError(error: error)
            })
            .disposed(by: disposeBag)
    }

    
    public func fetchAdditionalLocation(url: String) {
        guard !isLoadingMoreLocation else { return }
        self.isLoadingMoreLocation = true
        guard let pageNum = getPageNumber(from: url) else {
            self.isLoadingMoreLocation = false
            return
        }
        self.getAllLocation(pageNum)
    }
    
    func getPageNumber(from url: String) -> String? {
        guard let urlComponents = URLComponents(string: url) else { return nil }
        guard let pageQueryParam = urlComponents.queryItems?.first(where: { $0.name == "page" }) else { return nil }
        return pageQueryParam.value
    }
}

