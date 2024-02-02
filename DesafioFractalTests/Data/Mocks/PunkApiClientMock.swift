//
//  PunkApiClientMock.swift
//  DesafioFractalTests
//
//  Created by Joan Wilson Oliveira on 01/02/24.
//

import Foundation
@testable import DesafioFractal
final class PunkApiClientMock: BeerRemoteRepository {
    
    public var shouldFail: Bool
    
    private(set) var mockData: [Beer] = [
        .init(id: 1, name: "test1", tagline: "test1", description: "test1", imageURL: "test1"),
        .init(id: 1, name: "test1", tagline: "test1", description: "test1", imageURL: "test1")
    ]

    init(shouldFail: Bool) {
        self.shouldFail = shouldFail
    }
    
    func getBeers(page: Int, amount: Int, completion: @escaping (Result<[DesafioFractal.Beer], Error>) -> Void) {
        if shouldFail {
            completion(.failure(ErrorClient.errorRequest))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            if !self.shouldFail {
                completion(.success(self.mockData))
            } else {
                completion(.failure(ErrorClient.errorRequest))
            }
        }
    }
}
