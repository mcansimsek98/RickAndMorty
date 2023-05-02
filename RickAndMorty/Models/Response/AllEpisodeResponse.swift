//
//  AllEpisodeResponse.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 2.05.2023.
//

import Foundation

struct AllEpisodeResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [Episode]
}
