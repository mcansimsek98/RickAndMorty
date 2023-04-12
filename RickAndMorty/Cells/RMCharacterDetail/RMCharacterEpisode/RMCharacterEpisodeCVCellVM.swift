//
//  RMCharacterEpisodeVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 5.04.2023.
//

import Foundation

final class RMCharacterEpisodeCVCellVM: BaseVM {
    private let episdoeDataId: String?
    
    init(episdoeDataId: String?) {
        self.episdoeDataId = episdoeDataId
    }
}
