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
            return "/character"
        case .location:
            return "/location"
        case .episode:
            return "/episode"
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
