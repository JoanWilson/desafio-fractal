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
        setupTableView()
        
        client.getBeers(page: 1, amount: 1) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case .success(let beers):
                print(beers)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupTableView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
}

extension BeerListViewController: UITableViewDelegate {
    
}

extension BeerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BeerListTableViewCell.identifier,
            for: indexPath
        ) as? BeerListTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
