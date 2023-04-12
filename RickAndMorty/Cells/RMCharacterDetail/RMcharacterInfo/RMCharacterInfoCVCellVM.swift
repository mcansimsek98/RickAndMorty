//
//  RMCharacterInfoVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 5.04.2023.
//

import Foundation

final class RMCharacterInfoCVCellVM: BaseVM {
    
    public let value: String
    public let title: String
    
    init(value: String, title: String) {
        self.value = value
        self.title = title
    }

    
  
}
