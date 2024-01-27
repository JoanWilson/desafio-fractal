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
    
    private var viewModel: BeerListViewModel
    
    init(viewModel: BeerListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BeerList"
        
        setupNavigationBar()
        setupTableView()
        setupBinders()
        viewModel.fetchBeer(page: 1, amount: 25)
    }
    
    private func setupTableView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    
    private func setupBinders() {
        self.beersBinder()
    }
    
    private func beersBinder() {
        viewModel.$beers.sink { [weak self] _ in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.contentView.tableView.reloadData()
                self.showTableViewLoaded()
            }
        }.store(in: &viewModel.cancellable)
    }
    
    private func showTableViewLoaded() {
        contentView.tableView.isHidden = false
        contentView.loadingIndicator.stopAnimating()
    }
}

extension BeerListViewController {
    private func setupNavigationBar() {
        let navigationbarAppearance = UINavigationBarAppearance()
        
        navigationbarAppearance.backgroundColor = DesignSystem.Colors.primary
        let montserratFont: UIFont = DesignSystem.Fonts.montserratSemiBold(20)
        navigationbarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: DesignSystem.Colors.white,
            NSAttributedString.Key.font: montserratFont
        ]
        
        self.navigationController?.navigationBar.standardAppearance = navigationbarAppearance
        self.navigationController?.navigationBar.backgroundColor = DesignSystem.Colors.primary
        self.addSearchButton()
    
    }
    
    private func addSearchButton() {
        let searchButton = UIBarButtonItem(
            image: DesignSystem.Images.searchIcon,
            style: .plain,
            target: self,
            action: #selector(openSearchViewController)
        )
        
        searchButton.tintColor = DesignSystem.Colors.white
        
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func openSearchViewController() {
        print("Pesquisar")
    }
}

extension BeerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension BeerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.beers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.beerListTableViewHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BeerListTableViewCell.identifier,
            for: indexPath
        ) as? BeerListTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configureCell(using: viewModel.getBeers()[indexPath.row])
        
        return cell
    }
}
