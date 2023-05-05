//
//  Date+Extension.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 5.05.2023.
//

import Foundation

extension Date {
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
}
