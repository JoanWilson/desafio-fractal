//
//  BeerListViewController.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 25/01/24.
//

import UIKit

final class BeerListViewController: UIViewController {
    
    private var contentView: BeerListView
    private var viewModel: BeerListViewModel
    
    init(view: BeerListView, viewModel: BeerListViewModel) {
        self.contentView = view
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
        self.contentView.loadingIndicator.startAnimating()
        viewModel.fetchBeer(page: 1, amount: 25)
    }
    
    private func setupTableView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    
    private func setupBinders() {
        beersBinder()
        failedToFetchBinder()
    }
    
    private func beersBinder() {
        viewModel.$beers.sink { [weak self] _ in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.contentView.tableView.reloadData()
                self.showTableViewLoaded()
            }
        }
        .store(in: &viewModel.cancellable)
    }
    
    private func failedToFetchBinder() {
        viewModel.$failedToFetch.sink { [weak self] isFailed in
            guard let self else { return }
            
            DispatchQueue.main.async {
                if isFailed {
                    self.contentView.loadingIndicator.startAnimating()
                    self.showAlertWithAction(title: "Failed to Connect to internet", message: "Try Again") {
                        self.viewModel.fetchBeer(page: 1, amount: 25)
                    }
                } else {
                    self.contentView.loadingIndicator.stopAnimating()
                }
            }
        }.store(in: &viewModel.cancellable)
    }
    
    private func showTableViewLoaded() {
        contentView.loadingIndicator.stopAnimating()
        contentView.tableView.isHidden = false
    }
}

// MARK: - NavigationBar
extension BeerListViewController {
    private func setupNavigationBar() {
        let navigationbarAppearance = UINavigationBarAppearance()
        
        navigationbarAppearance.backgroundColor = DesignSystem.Colors.primary
        let montserratFont: UIFont = DesignSystem.Fonts.montserratSemiBold(20)
        navigationbarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: DesignSystem.Colors.whiteFont,
            NSAttributedString.Key.font: montserratFont
        ]
        
        self.navigationController?.navigationBar.standardAppearance = navigationbarAppearance
        self.navigationController?.navigationBar.backgroundColor = DesignSystem.Colors.primary
        self.navigationController?.navigationBar.tintColor = DesignSystem.Colors.whiteFont
        addSearchBar()
        addFavoritesButton()
    }
    
    private func addSearchBar() {
        navigationItem.searchController = contentView.searchController
        contentView.searchController.searchBar.delegate = self
    }
    
    private func addFavoritesButton() {
        let favoriteBarButtonItem = UIBarButtonItem(title: "Favorites", style: .done, target: self, action: #selector(navigateToFavoriteList))
        self.navigationItem.rightBarButtonItem  = favoriteBarButtonItem
    }
    
    @objc func navigateToFavoriteList() {
        let viewController = BeerFavoriteListFactory.makeViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - TableViewController
extension BeerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = BeerDetailFactory.makeViewController(for: viewModel.beers[indexPath.row])
        navigationController?.pushViewController(detailsViewController, animated: true)
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
        cell.configureCell(using: viewModel.beers[indexPath.row])
        
        return cell
    }
}

// MARK: - SearchController
extension BeerListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.isSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.filterBeers(by: "")
        viewModel.isSearching = false
        showNoResultsIfNotFound()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.isSearching = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterBeers(by: searchText.trimmingCharacters(in: .whitespaces))
        showNoResultsIfNotFound()
    }
    
    private func showNoResultsIfNotFound() {
        if self.viewModel.beers.isEmpty {
            self.contentView.noResultsView.isHidden = false
            self.navigationController?.navigationBar.backgroundColor = DesignSystem.Colors.white
            self.contentView.searchController.searchBar.searchTextField.backgroundColor = .systemBackground
            self.contentView.searchController.searchBar.tintColor = DesignSystem.Colors.primary
        } else {
            self.contentView.noResultsView.isHidden = true
            self.navigationController?.navigationBar.backgroundColor = DesignSystem.Colors.primary
            self.contentView.searchController.searchBar.searchTextField.backgroundColor = DesignSystem.Colors.searchBarBackground
            self.contentView.searchController.searchBar.tintColor = DesignSystem.Colors.white
        }
    }
}
