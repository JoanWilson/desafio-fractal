//
//  BeerUseCases.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 26/01/24.
//

import Foundation

final class BeerRemoteUseCases {
    
    private let repository: BeerRemoteRepository
    
    init(repository: BeerRemoteRepository) {
        self.repository = repository
    }
    
    func getBeers(page: Int, amount: Int, completion: @escaping (Result<[Beer], Error>) -> Void) {
        repository.getBeers(page: 1, amount: 1) { result in
            completion(result)
        }
    }
    
}
