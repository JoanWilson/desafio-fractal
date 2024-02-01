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
        beerRemoteUseCases.getBeers(page: page, amount: amount) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedBeers):
                cacheBeers = fetchedBeers.sorted { $0.name < $1.name }
                beers = fetchedBeers.sorted { $0.name < $1.name }
                failedToFetch = false 
            case .failure(let error):
                failedToFetch = true
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
