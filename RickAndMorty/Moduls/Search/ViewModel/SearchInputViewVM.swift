//
//  SearchInputViewVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 21.05.2023.
//

import Foundation

final class SearchInputViewVM {
    
    private let type: Config.`Type`
    
    enum DynamicOptions: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
        
        var queryArgument: String {
            switch self {
            case .status: return "status"
            case .gender: return "gender"
            case .locationType: return "type"
            }
        }
        
        var choies: [String] {
            switch self {
            case .status:
                return ["alive", "dead", "unknown"]
            case .gender:
                return ["male","female","genderless","unknown"]
            case .locationType:
                return ["cluster","planet","microverse"]
            }
        }
    }
    
    init(type: Config.`Type`) {
        self.type = type
    }
    
    public var hasDynamicOptions: Bool {
        switch self.type {
        case .character, .location:
            return true
        case .episode:
            return false
        }
    }
    
    public var options: [DynamicOptions] {
        switch self.type {
        case .character:
            return [.status, .gender]
        case .location:
            return [.locationType]
        case .episode:
            return []
        }
    }
    
    public var searchPlaceholdeerText: String {
        switch self.type {
        case .character:
            return "Character Name"
        case .location:
            return "Location Name"
        case .episode:
            return "Episode Title"
        }
    }
}
