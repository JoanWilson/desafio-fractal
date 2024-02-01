//
//  BeerDetailFactory.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 01/02/24.
//

import UIKit

public enum BeerDetailFactory {
    static public func makeViewController(for beer: Beer) -> UIViewController {
        let detailsViewModel = BeerDetailViewModel(beer: beer, useCases: BeerLocalUseCases(repository: CoreDataContainer()!))
        let viewController = BeerDetailViewController(viewModel: detailsViewModel)
        viewController.configureBeerDetail(with: beer)
        
        return viewController
    }
    
    static func makeViewController(for favoriteBeer: FavoriteBeer) -> BeerDetailViewController {
        let beer = Beer(
            id: Int(favoriteBeer.id),
            name: favoriteBeer.name!,
            tagline: favoriteBeer.tagline!,
            description: favoriteBeer.descriptionBeer!,
            imageURL: favoriteBeer.imageURL
        )
        let detailsViewModel = BeerDetailViewModel(beer: beer, useCases: BeerLocalUseCases(repository: CoreDataContainer()!))
        let viewController = BeerDetailViewController(viewModel: detailsViewModel)
        viewController.configureBeerDetail(with: beer)
        
        return viewController
    }
}
