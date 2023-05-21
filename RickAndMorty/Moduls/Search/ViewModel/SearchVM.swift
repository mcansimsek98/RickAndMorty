//
//  SearchVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 2.05.2023.
//

import Foundation
import RxSwift

final class SearchVM: BaseVM {
    let goToSearchPicerVC = PublishSubject<SearchInputViewVM.DynamicOptions>()
    private var optionMap: [SearchInputViewVM.DynamicOptions: String] = [:]
    private var optionMapUpdateBlock: (((SearchInputViewVM.DynamicOptions, String)) -> Void)?
    private var searchTetx = ""
    
    public func set(value: String, for option: SearchInputViewVM.DynamicOptions) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((SearchInputViewVM.DynamicOptions, String)) -> Void) {
        self.optionMapUpdateBlock = block
    }
    
    public func set(query text: String) {
        self.searchTetx = text
    }
    
    public func executeSearc() {
        //create request based on filters
    }
}
