//
//  TableView+Extension.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 6.05.2023.
//

import UIKit

extension UITableView {
    func isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
         return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
     }
}
