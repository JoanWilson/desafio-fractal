//
//  BeerDetailViewModel.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 29/01/24.
//

import Foundation
import Combine

final class BeerDetailViewModel {
    @Published var beer: Beer
    
    var isFavorite: Bool = false
    
    init(beer: Beer) {
        self.beer = beer
    }

}
