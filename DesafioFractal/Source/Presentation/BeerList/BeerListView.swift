//
//  BeerListView.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 25/01/24.
//

import UIKit

final class BeerListView: UIView {
    
    private lazy var backgroundHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DesignSystem.Colors.white
        
        return view
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = DesignSystem.Colors.white
        searchController.searchBar.placeholder = "Search Beers..."
        searchController.searchBar.setValue("Cancel", forKey: "cancelButtonText")

        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.searchTextField.backgroundColor = DesignSystem.Colors.searchBarBackground

        return searchController
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(
            BeerListTableViewCell.self,
            forCellReuseIdentifier: BeerListTableViewCell.identifier
        )
        tableView.backgroundColor = DesignSystem.Colors.white
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 40, right: 0)
        
        return tableView
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = DesignSystem.Colors.gray
        indicator.backgroundColor = DesignSystem.Colors.white
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        
        return indicator
    }()
    
    lazy var noResultsView: UIView = {
        let view = NoResultsFoundView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        buildLayout()
    }
    
    private func setupView() {
        self.backgroundColor = DesignSystem.Colors.secondary
    }
}

extension BeerListView: ViewCoding {
    func setupHierarchy() {
        addSubview(backgroundHeader)
        addSubview(tableView)
        addSubview(loadingIndicator)
        addSubview(noResultsView)
    }
    
    func setupConstraints() {
        tableViewConstraints()
        loadingIndicatorConstraints()
        backgroundHeaderConstraints()
        noResultsViewConstraints()
    }
    
    private func tableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func loadingIndicatorConstraints() {
        NSLayoutConstraint.activate([
            loadingIndicator.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loadingIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loadingIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func backgroundHeaderConstraints() {
        NSLayoutConstraint.activate([
            backgroundHeader.topAnchor.constraint(equalTo: self.topAnchor, constant: 90),
            backgroundHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundHeader.bottomAnchor.constraint(equalTo: tableView.topAnchor)
        ])
    }
    
    private func noResultsViewConstraints() {
        NSLayoutConstraint.activate([
            noResultsView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            noResultsView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            noResultsView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            noResultsView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
