//
//  BeerListView.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 25/01/24.
//

import UIKit

final class BeerListView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
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
        addSubview(tableView)
    }
    
    func setupConstraints() {
        self.tableViewConstraints()
    }
    
    private func tableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
