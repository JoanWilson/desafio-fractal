//
//  BeerListViewController.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 25/01/24.
//

import UIKit

final class BeerListViewController: UIViewController {
    
    private var contentView: BeerListView = .init()
    private let client: PunkApiClient = .init()
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BeerList"
        
        client.getBeers(page: 1, amount: 1) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let beers):
                print(beers)
            case .failure(let error):
                print(error)
            }
        }
    }
  
}
