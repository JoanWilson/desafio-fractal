//
//  BeerRepositoryProtocol.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 26/01/24.
//

import Foundation

protocol BeerRemoteRepositoryProtocol {
    func listBeers(page: Int, amount: Int?) -> [Beer]
    func searchBeer(byName inputText: String) -> [Beer]
}
