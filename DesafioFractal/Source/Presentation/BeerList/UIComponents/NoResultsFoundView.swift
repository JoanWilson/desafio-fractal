//
//  NoResultsFoundView.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 01/02/24.
//

import UIKit

final class NoResultsFoundView: UIView {
    
    private lazy var imageView: UIImageView = {
        let image = DesignSystem.Images.notFoundImage
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 193).isActive = true
        
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No results were found"
        label.font = DesignSystem.Fonts.montserratBold(18)
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buildLayout()
    }
}

extension NoResultsFoundView: ViewCoding {
    func setupHierarchy() {
        addSubview(imageView)
        addSubview(label)
    }
    
    func setupConstraints() {
        imageViewConstraints()
        labelConstraints()
    }
    
    private func imageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    
    private func labelConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
}
