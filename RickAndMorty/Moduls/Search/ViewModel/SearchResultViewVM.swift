//
//  SearchResultVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 22.05.2023.
//

import Foundation

enum SearchResultViewVM {
    case characters([RMCharacterCVCellVM])
    case episode([RMEpisodeCVCellVM])
    case locations([LocationTVCellVM])
}
