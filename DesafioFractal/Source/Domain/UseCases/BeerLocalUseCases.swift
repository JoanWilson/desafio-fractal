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
    
    func listAllFavoriteBeer() -> Result<[FavoriteBeer], Error> {
        do {
            let beers = try repository.listAllFavoriteBeer()
            return .success(beers)
        } catch {
            return .failure(error)
        }
    }
    
    func getBeerById(id: Int) -> FavoriteBeer? {
        return repository.getFavoriteBeerById(id: Int64(id))
    }
    
    func saveABeerAsFavorite(using dto: FavoriteBeerDTO) -> Result<FavoriteBeer, Error> {
        do {
            let beer = try repository.saveFavoriteBeer(using: dto)
            return .success(beer)
        } catch {
            return .failure(error)
        }
    }
    
    func deleteBeerById(id: Int) -> Result<Bool, Error> {
        do {
            try repository.deleteBeerById(id: Int64(id))
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
}
