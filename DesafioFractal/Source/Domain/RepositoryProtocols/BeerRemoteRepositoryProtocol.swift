//
//  BeerRepositoryProtocol.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 26/01/24.
//

import Foundation

protocol BeerRemoteRepository {
    func getBeers(page: Int, amount: Int, completion: @escaping (Result<[Beer], Error>) -> Void)
}
