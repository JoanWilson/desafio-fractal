//
//  ViewCoding.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 25/01/24.
//

import Foundation

protocol ViewCoding {
    func setupHierarchy()
    func setupConstraints()
}

extension ViewCoding {
    func buildLayout() {
        setupHierarchy()
        setupConstraints()
    }
}
