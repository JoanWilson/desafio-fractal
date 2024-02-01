//
//  BeerListViewModel.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 25/01/24.
//

import Foundation
import Combine

final class BeerListViewModel {
    
    @Published private(set) var beers: [Beer] = []
    @Published private(set) var failedToFetch: Bool = false
    private var cacheBeers: [Beer] = []
    
    var isSearching: Bool = false
    var cancellable: Set<AnyCancellable> = []
    var beerListTableViewHeight: CGFloat = 90
    
    private let beerRemoteUseCases: BeerRemoteUseCases
    
    init(beerRemoteUseCases: BeerRemoteUseCases) {
        self.beerRemoteUseCases = beerRemoteUseCases
    }
    
    func fetchBeer(page: Int, amount: Int) {
        beerRemoteUseCases.getBeers(page: page, amount: amount) { result in
            
            switch result {
            case .success(let fetchedBeers):
                self.cacheBeers = fetchedBeers.sorted { $0.name < $1.name }
                self.beers = fetchedBeers.sorted { $0.name < $1.name }
                self.failedToFetch = false
            case .failure(let error):
                self.failedToFetch = true
                print(error)
            }
        }
    }
    
    func filterBeers(by inputText: String) {
        beers = inputText.isEmpty ? cacheBeers : cacheBeers.filter {
            $0.name.lowercased().contains(inputText.lowercased())
        }
    }
    
}
