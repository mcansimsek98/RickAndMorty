//
//  Config.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 7.05.2023.
//

import Foundation

struct Config {
    enum `Type` {
        case character
        case episode
        case location
        
        var title: String {
            switch self {
            case .character:
                return "Search Characters"
            case .episode:
                return "Search Episode"
            case .location:
                return "Search Location"
            }
        }
    }
    let type: `Type`
}
