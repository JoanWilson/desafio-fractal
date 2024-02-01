//
//  BeerListFactory.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 27/01/24.
//

import UIKit

public enum BeerListFactory {
    static public func makeViewController() -> UIViewController {
        let repository = PunkApiClient(apiURL: "https://api.punkapi.com/v2/beers?page=1", session: URLSession(configuration: .default))
        let useCase = BeerRemoteUseCases(repository: repository)
        let viewModel = BeerListViewModel(beerRemoteUseCases: useCase)
        let view = BeerListView()
        let viewController = BeerListViewController(view: view, viewModel: viewModel)
        
        return viewController
    }
}
