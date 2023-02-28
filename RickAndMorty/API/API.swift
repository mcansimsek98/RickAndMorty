//
//  API.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 28.02.2023.
//

import Foundation
import Moya

enum API {
    case character
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
            return ""
        case .location:
            return ""
        case .episode:
            return ""
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
        case .character:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case .location:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case .episode:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
