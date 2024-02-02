//
//  BeerListViewModel.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 25/01/24.
//

import Foundation
import Combine

final class FavoriteBeerListViewModel {
    
    @Published private(set) var beers: [FavoriteBeer] = []
    @Published private(set) var failedToFetch: Bool = false
    private var cacheBeers: [FavoriteBeer] = []
    
    var isSearching: Bool = false
    var cancellable: Set<AnyCancellable> = []
    var beerListTableViewHeight: CGFloat = 90
    
    private let beerLocalUseCases: BeerLocalUseCases
    
    init(beerLocalUseCases: BeerLocalUseCases) {
        self.beerLocalUseCases = beerLocalUseCases
    }
    
    func fetchBeer() {
        let result = beerLocalUseCases.listAllFavoriteBeer()
        
        switch result {
        case .success(let fetchedBeers):
            print(fetchedBeers)
            cacheBeers = fetchedBeers.sorted { $0.name! < $1.name! }
            beers = fetchedBeers.sorted { $0.name! < $1.name! }
            failedToFetch = false
        case .failure(let error):
            print(error)
            failedToFetch = true
        }
    }
    
    func filterBeers(by inputText: String) {
        beers = inputText.isEmpty ? cacheBeers : cacheBeers.filter {
            $0.name!.lowercased().contains(inputText.lowercased())
        }
    }
    
}
