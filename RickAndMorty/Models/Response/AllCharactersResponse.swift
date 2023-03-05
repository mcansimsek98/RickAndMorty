//
//  AllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 1.03.2023.
//

import Foundation

struct AllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [Character]
}
