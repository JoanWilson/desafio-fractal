//
//  BeerDetailViewModel.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 29/01/24.
//

import Foundation
import Combine

final class BeerDetailViewModel {
    @Published var beer: Beer
    @Published var isFavorite: Bool
    var cancellable: Set<AnyCancellable> = []
    
    private let useCases: BeerLocalUseCases
    
    init(beer: Beer, useCases: BeerLocalUseCases) {
        self.beer = beer
        self.useCases = useCases
        
        guard useCases.getBeerById(id: beer.id) != nil else {
            isFavorite = false
            return
        }
        
        isFavorite = true
    }
    
    func favoriteBeer(dto: FavoriteBeerDTO) -> Bool {
        let result = useCases.saveABeerAsFavorite(using: dto)
        switch result {
        case .success(let beer):
            print(beer)
            return true
        case .failure(let error):
            print(error)
            return false
        }
    }
    
    func unfavoriteBeer(id: Int) -> Bool {
        let result = useCases.deleteBeerById(id: id)
        switch result {
        case .success(let beer):
            print(beer)
            return true
        case .failure(let error):
            print(error)
            return false
        }
    }
    
    func makeDTOWithImageData(imageData: Data) -> FavoriteBeerDTO {
        let dto = FavoriteBeerDTO(
            id: Int64(beer.id),
            name: beer.name,
            tagline: beer.tagline,
            description: beer.description,
            imageData: imageData,
            imageURL: beer.imageURL!
        )
        
        return dto
    }
    
}
