//
//  RMCharacterDetailViewVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 18.03.2023.
//

import Foundation

final class RMCharacterDetailViewVM: BaseVM {
    let character: Character
    
    init(_ character: Character) {
        self.character = character
    }
    
    public var title: String {
        character.name?.uppercased() ?? ""
    }
}
