//
//  String+Extension.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 11.03.2023.
//

import Foundation


extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
