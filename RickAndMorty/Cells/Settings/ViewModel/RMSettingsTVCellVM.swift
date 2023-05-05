//
//  RMSettingsTVCellVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 5.05.2023.
//

import UIKit

struct RMSettingsTVCellVM: Identifiable {
    let id = UUID()
    public let type: RMSettingsOption
    public let onTapHandler: (RMSettingsOption) -> Void
    
    init(type: RMSettingsOption, onTapHandler: @escaping (RMSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    public var image: UIImage? {
        return type.iconImage
    }
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }

}
