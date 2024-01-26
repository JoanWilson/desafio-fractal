//
//  BeerRemoteRepository.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 26/01/24.
//

import Foundation

final class BeerRemoteRepository: BeerRemoteRepositoryProtocol {
    
    
    
    func listBeers(page: Int, amount: Int?) -> [Beer] {
        return []
    }
    
    func searchBeer(byName inputText: String) -> [Beer] {
        return []
    }
    
    func requestBeer(completion: @escaping (Result<Beer, Error>) -> Void) {
        
    }
}
