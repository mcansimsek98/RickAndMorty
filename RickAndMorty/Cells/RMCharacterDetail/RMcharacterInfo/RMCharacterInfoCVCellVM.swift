//
//  RMCharacterInfoVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 5.04.2023.
//

import UIKit

final class RMCharacterInfoCVCellVM: BaseVM {
    private let type: `Type`
    private let value: String
    
    static let dateFormater: DateFormatter = {
        let formater = DateFormatter()
        formater.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSSZ"
        formater.timeZone = .current
        return formater
    }()
    
    static let shortDateFormater: DateFormatter = {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .short
        return formater
    }()
    
    public var title: String {
        type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty{ return "None"}
        
        if let date = Self.dateFormater.date(from: value), type == .created {
            return Self.shortDateFormater.string(from: date)
        }
        return value
    }
    
    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var tintColor: UIColor {
        return type.tintColor
    }
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case orgin
        case location
        case created
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status, .species, .orgin, .episodeCount:
                return .systemBlue
            case .gender, .type, .location, .created:
                return .systemRed
//            case .status:
//                return .systemBlue
//            case .gender:
//                return .systemRed
//            case .type:
//                return .systemCyan
//            case .species:
//                return .systemGray
//            case .orgin:
//                return .systemPink
//            case .location:
//                return .systemTeal
//            case .created:
//                return .systemBrown
//            case .episodeCount:
//                return .systemMint
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .orgin:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status, .gender, .type, .species, .orgin, .location, .created:
                return rawValue.uppercased()
            case .episodeCount:
                return "EPISODE COUNT"
            }
        }
    }
    
    init(type: `Type`,value: String) {
        self.value = value
        self.type = type
    }
    
    
    
}
