//
//  CoreDataManagerTests.swift
//  DesafioFractalTests
//
//  Created by Joan Wilson Oliveira on 01/02/24.
//

import XCTest
@testable import DesafioFractal

final class CoreDataManagerTests: XCTestCase {
    
    private var sut: CoreDataContainer!
    
    override func setUpWithError() throws {
        sut = CoreDataContainer(inMemory: true)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_listAllFavoriteBeer_ShouldReturnAllFavoriteBeers() throws {
        let dto = FavoriteBeerDTO(id: 1, name: "name", tagline: "test", description: "test", imageData: Data(), imageURL: "")
        _ = try sut.saveFavoriteBeer(using: dto)
        let favoriteBeers = try sut.listAllFavoriteBeer()
        XCTAssertEqual(favoriteBeers.count, 1)
    }
    
    func test_getFavoriteBeerById_ShouldReturnCorrectFavoriteBeer() throws {
        let dto = FavoriteBeerDTO(id: 1, name: "name", tagline: "test", description: "test", imageData: Data(), imageURL: "")
        _ = try sut.saveFavoriteBeer(using: dto)
        
        guard let retrievedBeer = sut.getFavoriteBeerById(id: dto.id) else {
            XCTFail("No beer found with given ID")
            return
        }
        
        XCTAssertEqual(retrievedBeer.id, dto.id)
        XCTAssertEqual(retrievedBeer.name, dto.name)
        XCTAssertEqual(retrievedBeer.tagline, dto.tagline)
        print(retrievedBeer, dto)
        XCTAssertEqual(retrievedBeer.descriptionBeer, dto.description)
        XCTAssertEqual(retrievedBeer.image, dto.imageData)
    }
    
    func test_deleteBeerById_ShouldRemoveFavoriteBeer() throws {
        let dto = FavoriteBeerDTO(id: 1, name: "name", tagline: "test", description: "test", imageData: Data(), imageURL: "")
        _ = try sut.saveFavoriteBeer(using: dto)
        
        try sut.deleteBeerById(id: dto.id)
        
        let favoriteBeers = try sut.listAllFavoriteBeer()
        XCTAssertTrue(favoriteBeers.isEmpty)
    }

}
