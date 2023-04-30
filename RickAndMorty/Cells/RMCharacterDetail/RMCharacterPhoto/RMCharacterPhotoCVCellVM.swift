//
//  RMCharacterPhotoVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 5.04.2023.
//

import Foundation

final class RMCharacterPhotoCVCellVM: BaseVM {
    let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
}
