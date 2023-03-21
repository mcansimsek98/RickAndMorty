//
//  RMCharacterCVCellVM.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 13.03.2023.
//

import Foundation


final class RMCharacterCVCellVM: BaseVM {
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    init(characterName: String, characterStatus: RMCharacterStatus, characterImageUrl: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var characterStatusText: String {
        return "status".localized() + ": " + characterStatus.text
    }
    
    public func fetchImage(complation: @escaping (Result<Data, Error>) -> Void ) {
        //TODO: Abstract to image Manager
        guard let url = characterImageUrl else {
            complation(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                complation(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            complation(.success(data))
        }
        task.resume()
    }
}
