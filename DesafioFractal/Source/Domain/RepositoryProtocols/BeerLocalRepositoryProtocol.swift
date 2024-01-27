//
//  BeerLocalRepositoryProtocol.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 26/01/24.
//

import Foundation

protocol BeerLocalRepositoryProtocol {
    func getBeerById(_ id: Int) -> Beer
    func saveAsFavorite(_ beer: Beer)
    func removeFromFavorite(_ beer: Beer)
}
