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
    
    lazy var navView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BeerList"
        
        setupNavigationBar()
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
    
    private func setupNavigationBar() {
        let navigationbarAppearance = UINavigationBarAppearance()
        
        navigationbarAppearance.backgroundColor = DesignSystem.Tokens.Colors.primary
        let montserratFont: UIFont = DesignSystem.Tokens.Fonts.montserratSemiBold(20)
        navigationbarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: DesignSystem.Tokens.Colors.white,
            NSAttributedString.Key.font: montserratFont
        ]
        
        self.navigationController?.navigationBar.standardAppearance = navigationbarAppearance
        self.navigationController?.navigationBar.backgroundColor = DesignSystem.Tokens.Colors.primary
    }
    
    private func setupTableView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
}

extension BeerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension BeerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BeerListTableViewCell.identifier,
            for: indexPath
        ) as? BeerListTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        return cell
    }
}
