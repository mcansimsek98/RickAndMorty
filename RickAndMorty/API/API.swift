//
//  API.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 28.02.2023.
//

import Foundation
import Moya

enum SearchQueryType {
    case character
    case episode
    case location
    
    var model: Any {
        switch self {
        case .character:
            return Character.self
        case .episode:
            return Episode.self
        case .location:
            return Location.self
        }
    }
}

enum API {
    case character(query: String)
    case characterDetail(id: String)
    case characterDetailEpisode(id: String)
    case location(query: String)
    case episode(query: String)
    case locationDetail(id: String)
    case search(parm: SearchQueryType, query: String)
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
        case .locationDetail(let id):
            return "/location/\(id)"
        case .search(let parm, _):
            switch parm {
            case .character:
                return "/character/"
            case .episode:
                return "/episode/"
            case .location:
                return "/location/"
            }
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
        case .character(let query), .episode(let query), .location(let query):
            return .requestParameters(parameters: ["page": "\(query)"], encoding: URLEncoding.queryString)
        case .characterDetail, .characterDetailEpisode, .locationDetail:
            return .requestPlain
        case .search(let parm, let query):
            switch parm {
            case .character:
                return .requestParameters(parameters: ["name": "\(query)", "status": "\(query)", "gender": "\(query)"], encoding: URLEncoding.queryString)
            case .episode:
                return .requestParameters(parameters: ["name": "\(query)"], encoding: URLEncoding.queryString)
            case .location:
                return .requestParameters(parameters: ["name": "\(query)", "type": "\(query)"], encoding: URLEncoding.queryString)
            }
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
