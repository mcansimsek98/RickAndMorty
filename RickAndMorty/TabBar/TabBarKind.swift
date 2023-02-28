//
//  TabBarKind.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import Foundation
import UIKit

enum TabBarKind : Int {
    case characters
    case locations
    case sections
    case settings
    
    var title: String? {
        switch self {
        case .characters:
            return "Karakterler"
        case .locations:
            return "Lokasyon"
        case .sections:
            return "Bölümler"
        case .settings:
            return "Ayarlar"
        }
    }
    var icon: UIImage? {
        switch self {
        case .characters:
            return UIImage(systemName: "person")
        case .locations:
            return UIImage(systemName: "globe")
        case .sections:
            return UIImage(systemName: "tv")
        case .settings:
            return UIImage(systemName: "gear")
        }
    }
    
    var navigationController: UINavigationController {
        let nav = UINavigationController()
        nav.tabBarItem.title = self.title
        nav.tabBarItem.image = self.icon
        return nav
    }
    
    static var items: [TabBarKind] {
        return [.characters, .locations, .sections, .settings]
    }
}
