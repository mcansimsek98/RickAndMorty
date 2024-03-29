//
//  RMEpisodeVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import Foundation
import RxSwift

class RMEpisodeVM : BaseVM {
    let searchAction = PublishSubject<Config>()
    let gotoDetailEpisode = PublishSubject<String>()
}
