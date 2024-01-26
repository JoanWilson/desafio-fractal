//
//  BeerUseCases.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 26/01/24.
//

import Foundation

final class BeerRemoteUseCases {
    
    private let repository: BeerRemoteRepositoryProtocol
    
    init(repository: BeerRemoteRepositoryProtocol) {
        self.repository = repository
    }
    
    func listAllBeers(page: Int, amount: Int?) -> [Beer] {
        return repository.listBeers(page: page, amount: amount)
    }
    
    func searchBeer(byName inputText: String) -> [Beer] {
        return repository.searchBeer(byName: inputText)
    }
    
}
