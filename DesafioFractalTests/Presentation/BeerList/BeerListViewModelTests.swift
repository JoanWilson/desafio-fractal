//
//  BeerListViewModelTests.swift
//  DesafioFractalTests
//
//  Created by Joan Wilson Oliveira on 01/02/24.
//

import XCTest
@testable import DesafioFractal

final class BeerListViewModelTests: XCTestCase {
    
    private var sut: BeerListViewModel!
    private var mockRepository: PunkApiClientMock!
    
    override func setUpWithError() throws {
        mockRepository = PunkApiClientMock(shouldFail: false)
        let useCases = BeerRemoteUseCases(repository: mockRepository)
        sut = BeerListViewModel(beerRemoteUseCases: useCases)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockRepository = nil
    }
    
    func test_FetchBeer_ShouldBeSuccess() {
        sut.fetchBeer(page: 1, amount: 2)
        XCTAssertFalse(sut.failedToFetch)
    }
    
    func test_FetchBeer_ShouldBeFailure() {
        mockRepository = PunkApiClientMock(shouldFail: true)
        mockRepository.shouldFail = true
        let useCases = BeerRemoteUseCases(repository: mockRepository)
        sut = BeerListViewModel(beerRemoteUseCases: useCases)
        
        sut.fetchBeer(page: 1, amount: 2)
        print(sut.failedToFetch)
        XCTAssert(sut.failedToFetch)
    }
    
}
