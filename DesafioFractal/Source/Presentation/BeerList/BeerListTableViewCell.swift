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
        view.backgroundColor = DesignSystem.Colors.background
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var image: UIImageView = {
        let image = DesignSystem.Images.mockImageCell
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AB: 01"
        label.font = DesignSystem.Fonts.montserratBold(18)
        label.textColor = DesignSystem.Colors.gray
        
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Triple Dry Hopped Imperial Red."
        label.font = DesignSystem.Fonts.montserratMedium(14)
        label.textColor = DesignSystem.Colors.lightGray
        
        return label
    }()
    
    private lazy var stackLabels: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        
        return stack
    }()
    
    private lazy var arrowIcon: UIImageView = {
        let image = DesignSystem.Images.arrowRight
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = DesignSystem.Colors.white
        buildLayout()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16))
    }
    
    public func configureCell(using beer: Beer) {
        title.text = beer.name
        subTitle.text = beer.tagline
        
        guard let beerImageURLString = beer.imageURL,
              let beerImageURL = URL(string: beerImageURLString) else {
            print("Beer Image URL Not Found")
            return
        }
        image.load(url: beerImageURL)
    }
}

extension BeerListTableViewCell: ViewCoding {
    func setupHierarchy() {
        self.contentView.addSubview(cellContent)
        self.contentView.addSubview(image)
        self.contentView.addSubview(arrowIcon)
        
        stackLabels.addArrangedSubview(title)
        stackLabels.addArrangedSubview(subTitle)
        self.contentView.addSubview(stackLabels)
    }
    
    func setupConstraints() {
        self.cellContentConstraints()
        self.imageConstraints()
        self.stackConstraints()
        self.arrowIconConstraints()
    }
    
    private func cellContentConstraints() {
        NSLayoutConstraint.activate([
            cellContent.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            cellContent.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            cellContent.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            cellContent.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
    private func imageConstraints() {
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            image.heightAnchor.constraint(equalToConstant: 46),
            image.widthAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    private func stackConstraints() {
        NSLayoutConstraint.activate([
            stackLabels.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 4),
            stackLabels.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 18),
            stackLabels.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -18),
            stackLabels.trailingAnchor.constraint(equalTo: arrowIcon.leadingAnchor, constant: -3)
        ])
    }
    
    private func arrowIconConstraints() {
        NSLayoutConstraint.activate([
            arrowIcon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            arrowIcon.heightAnchor.constraint(equalToConstant: 16),
            arrowIcon.widthAnchor.constraint(equalToConstant: 16),
            arrowIcon.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8)
        ])
    }
    
}
