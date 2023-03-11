//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 11.03.2023.
//

import UIKit

final class CharacterListView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
}
