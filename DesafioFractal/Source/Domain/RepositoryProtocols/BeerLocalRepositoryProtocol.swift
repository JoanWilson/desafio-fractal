//
//  BeerLocalRepositoryProtocol.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 26/01/24.
//

import Foundation

protocol BeerLocalRepositoryProtocol {
    func listAllFavoriteBeer() throws -> [FavoriteBeer]
    func saveFavoriteBeer(using dto: FavoriteBeerDTO) throws -> FavoriteBeer
    func getFavoriteBeerById(id: Int64) -> FavoriteBeer?
    func deleteBeerById(id: Int64) throws
}
