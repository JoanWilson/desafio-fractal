//
//  BeerTableViewCell.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 26/01/24.
//

import UIKit

final class BeerListTableViewCell: UITableViewCell {
    
    static let identifier: String = "BeerTableViewCell"
    
    private lazy var cellContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DesignSystem.Tokens.Colors.background
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buildLayout()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}

extension BeerListTableViewCell: ViewCoding {
    func setupHierarchy() {
        contentView.addSubview(cellContent)
    }
    
    func setupConstraints() {
        self.cellContentConstraints()
    }
    
    private func cellContentConstraints() {
        NSLayoutConstraint.activate([
            cellContent.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            cellContent.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            cellContent.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            cellContent.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
}
