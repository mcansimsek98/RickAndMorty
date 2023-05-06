//
//  LocationTVCellVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 6.05.2023.
//

import UIKit
import RxDataSources

final class LocationTVCellVM: BaseVM, IdentifiableType {
    internal let identity: Int
    let locationId : Int
    private let location: Location
    
    init(locationId: Int, location: Location) {
        self.identity = locationId
        self.locationId = locationId
        self.location = location
    }
    
    public var name: String {
        return location.name ?? ""
    }
    
    public var type: String {
        return "Type: " + (location.type ?? "") 
    }
    
    public var dimension: String {
        return location.dimension ?? ""
    }
        
}
