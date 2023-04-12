//
//  RMCharacterPhotoVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 5.04.2023.
//

import Foundation

final class RMCharacterPhotoCVCellVM: BaseVM {
    private let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
}
