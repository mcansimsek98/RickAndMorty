//
//  Episode.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 28.02.2023.
//

import Foundation

struct Episode: Codable, RMEpisodeDataRender {
    var id: Int?
    var name: String
    var air_date: String
    var episode: String
    var characters: [String]
    var url: String?
    var created: String?
}
