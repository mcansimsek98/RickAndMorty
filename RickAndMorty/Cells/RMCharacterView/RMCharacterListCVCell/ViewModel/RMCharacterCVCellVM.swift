//
//  RMCharacterCVCellVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 13.03.2023.
//

import Foundation
import RxDataSources

final class RMCharacterCVCellVM: BaseVM, IdentifiableType {
    var identity: Int
    
    let characterId : Int
    let characterName: String
    let characterStatusText: String
    let characterImageUrl: URL?
    
    init(characterId: Int, characterName: String, characterStatus: RMCharacterStatus, characterImageUrl: URL?) {
        self.identity = characterId
        self.characterId = characterId
        self.characterName = characterName
        self.characterStatusText = "status".localized() + ": " + characterStatus.text
        self.characterImageUrl = characterImageUrl
    }
}
