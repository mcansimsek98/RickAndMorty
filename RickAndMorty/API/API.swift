//
//  API.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 28.02.2023.
//

import Foundation
import Moya

enum API {
    case character(query: String)
    case characterDetail(id: String)
    case characterDetailEpisode(id: String)
    case location
    case episode
    
}

extension API : TargetType {
    var baseURL: URL {
        return URL(string: "https://rickandmortyapi.com/api")!
    }
    
    var path: String {
        switch self {
        case .character:
            return "/character"
        case .characterDetail(let id):
            return "/character/\(id)"
        case .location:
            return "/location"
        case .episode:
            return "/episode"
        case .characterDetailEpisode(let id):
            return "/episode/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .character(let query):
            return .requestParameters(parameters: ["page": "\(query)"], encoding: URLEncoding.queryString)
        case .characterDetail, .characterDetailEpisode:
            return .requestPlain
        case .location:
            return .requestPlain
        case .episode:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
