//
//  BeerListView.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 25/01/24.
//

import UIKit

final class BeerListView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = DesignSystem.Tokens.Colors.white
    }
    
}

extension BeerListView: ViewCoding {
    
    func setupHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
}
