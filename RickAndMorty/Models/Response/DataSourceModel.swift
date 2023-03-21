//
//  DataSourceModel.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 20.03.2023.
//

import Foundation
import RxDataSources

//struct DataSorceModel<T> {
//      var header: String
//      var isMultiple : Bool?
//      var items: [Item]
//}
//
//extension DataSorceModel : SectionModelType{
//
//        typealias Item = T
//
//       init(original: DataSorceModel, items: [Item]) {
//            self = original
//            self.items = items
//      }
//
//
//}


//
//extension DataSorceModel: IdentifiableType, Equatable {
//
//    typealias Identity = Int
//    typealias Item = T
//
//    var identity: Identity {
//        return id
//    }
//
//    init(original: DataSorceModel, items: [Item]) {
//        self = original
//        self.items = items
//    }
//}
//
//struct SectionOfCustomDataAnimated {
//    var items: [Item]
//
//    // Need to provide a unique id, only one section in our model
//    var identity: Int {
//        return 0
//    }
//}
//
//extension SectionOfCustomDataAnimated: AnimatableSectionModelType {
//    typealias Identity = Int
//    typealias Item = CustomDataAnimated
//
//    init(original: SectionOfCustomDataAnimated, items: [Item]) {
//        self = original
//        self.items = items
//    }
//}

struct DataSourceModel<Item: IdentifiableType & Equatable>: AnimatableSectionModelType {
    typealias Identity = String

    var identity: String {
        return header
    }

    var header: String
    var items: [Item]

    init(header: String, items: [Item]) {
        self.header = header
        self.items = items
    }

    init(original: DataSourceModel<Item>, items: [Item]) {
        self = original
        self.items = items
    }

    mutating func replaceItem(_ item: Item) -> DataSourceModel<Item> {
        guard let index = items.firstIndex(where: { $0.identity == item.identity }) else {
            return self
        }
        var newItems = items
        newItems[index] = item
        return DataSourceModel<Item>(header: self.header, items: newItems)
    }
}
