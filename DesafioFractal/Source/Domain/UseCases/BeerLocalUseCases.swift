//
//  BeerLocalUseCases.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 26/01/24.
//

import Foundation

final class BeerLocalUseCases {
    
    private let repository: BeerLocalRepositoryProtocol
    
    init(repository: BeerLocalRepositoryProtocol) {
        self.repository = repository
    }
    
    func getBeerById(_ id: Int) -> Beer {
        return repository.getBeerById(id)
    }
    
    func saveAsFavorite(_ beer: Beer) {
        return repository.saveAsFavorite(beer)
    }
    
    func removeFromFavorite(_ beer: Beer) {
        return repository.removeFromFavorite(beer)
    }
    
}
