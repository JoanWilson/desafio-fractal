//
//  BeerListViewController.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 25/01/24.
//

import UIKit

final class FavoriteBeerListViewController: UIViewController {
    
    private var contentView: BeerListView
    private var viewModel: FavoriteBeerListViewModel
    
    init(view: BeerListView, viewModel: FavoriteBeerListViewModel) {
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
        self.title = "FavoriteBeers"
        setupNavigationBar()
        setupTableView()
        setupBinders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchBeer()
    }
    
    private func setupTableView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    
    private func setupBinders() {
        self.beersBinder()
    }
    
    private func beersBinder() {
        viewModel.$beers.sink { [weak self] beers in
            guard let self else { return }
            
            if beers.isEmpty {
                contentView.noResultsView.label.text = "There is no favorite beer found"
                contentView.noResultsView.isHidden = false
            } else {
                contentView.noResultsView.isHidden = true
            }
            
            DispatchQueue.main.async {
                self.contentView.tableView.reloadData()
                self.showTableViewLoaded()
            }
        }
        .store(in: &viewModel.cancellable)
    }
    
    private func showTableViewLoaded() {
        contentView.loadingIndicator.stopAnimating()
        contentView.tableView.isHidden = false
    }
}

// MARK: - NavigationBar
extension FavoriteBeerListViewController {
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
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        addSearchBar()
    }
    
    private func addSearchBar() {
        navigationItem.searchController = contentView.searchController
        contentView.searchController.searchBar.delegate = self
    }
}

// MARK: - TableViewController
extension FavoriteBeerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteBeer = viewModel.beers[indexPath.row]
        let detailsViewController = BeerDetailFactory.makeViewController(for: favoriteBeer)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension FavoriteBeerListViewController: UITableViewDataSource {
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
        cell.configureCellWithData(using: viewModel.beers[indexPath.row])
        
        return cell
    }
}

// MARK: - SearchController
extension FavoriteBeerListViewController: UISearchBarDelegate {
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
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.isSearching = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterBeers(by: searchText.trimmingCharacters(in: .whitespaces))
    }
}
