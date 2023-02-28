//
//  Character.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 28.02.2023.
//

import Foundation

struct Character: Codable{
    let id: Int?
    let name: String?
    let status: RMCharacterStatus
    let species: String?
    let type: String?
    let gender: RMCharacterGender
    let origin: RMOrigin
    let location: RMLocation
    let image: String?
    let episode: [String]
    let url: String?
    let created: String?
}


