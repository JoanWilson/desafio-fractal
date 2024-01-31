//
//  BeerListFactory.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 27/01/24.
//

import UIKit

public enum BeerListFactory {
    static public func makeViewController() -> UIViewController {
        let repository = PunkApiClient()
        let useCase = BeerRemoteUseCases(repository: repository)
        let viewModel = BeerListViewModel(beerRemoteUseCases: useCase)
        let view = BeerListView()
        let viewController = BeerListViewController(view: view, viewModel: viewModel)
        
        return viewController
    }
}
