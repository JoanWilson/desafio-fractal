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
        contentView.loadingIndicator.stopAnimating()
        contentView.tableView.isHidden = false
    }
}

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
        self.addSearchButton()
    
    }
    
    private func addSearchButton() {
        let searchButton = UIBarButtonItem(
            image: DesignSystem.Images.searchIcon,
            style: .plain,
            target: self,
            action: #selector(openSearchViewController)
        )
        
        searchButton.tintColor = DesignSystem.Colors.whiteFont
        
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func openSearchViewController() {
        print("Pesquisar")
    }
}

extension BeerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewModel = BeerDetailViewModel(beer: viewModel.getBeers()[indexPath.row])
        let detailsViewController = BeerDetailViewController(viewModel: detailsViewModel)
        detailsViewController.configureBeerDetail(with: viewModel.getBeers()[indexPath.row])
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
        cell.configureCell(using: viewModel.getBeers()[indexPath.row])
        
        return cell
    }
}
