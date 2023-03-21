//
//  DataSourceModel.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 20.03.2023.
//

import Foundation
import RxDataSources

struct DataSorceModel<T> {
      var header: String
      var isMultiple : Bool?
      var items: [Item]
}

extension DataSorceModel : SectionModelType{
    
        typealias Item = T

       init(original: DataSorceModel, items: [Item]) {
            self = original
            self.items = items
      }
    
    
}
