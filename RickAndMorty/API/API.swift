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
    case location(query: String)
    case episode(query: String)
    case locationDetail(id: String)
    case searchCharacter(query: String, parm: [String: String])
    case searchEpisode(query: String, parm: [String: String])
    case searchlocation(query: String, parm: [String: String])

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
        case .searchCharacter:
            return "/character/"
        case .searchEpisode:
            return "/episode/"
        case .searchlocation:
            return "/location/"
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
            
        case .searchCharacter(let query, let parm), .searchEpisode(let query, let parm), .searchlocation(let query, let parm):
            var dic = ["name": "\(query)"]
            for (option, value) in parm {
               dic["\(option)"] = value
            }
            return .requestParameters(parameters: dic, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
