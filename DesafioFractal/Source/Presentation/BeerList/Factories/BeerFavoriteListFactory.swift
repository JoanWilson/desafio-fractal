//
//  BeerDetailFactory.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 01/02/24.
//

import UIKit

public enum BeerFavoriteListFactory {
    static public func makeViewController() -> UIViewController {
        let repository = CoreDataContainer()!
        let useCases = BeerLocalUseCases(repository: repository)
        let view = BeerListView()
        let viewModel = FavoriteBeerListViewModel(beerLocalUseCases: useCases)
        let viewController = FavoriteBeerListViewController(
            view: view,
            viewModel: viewModel
        )
        
        return viewController
    }
    
}
