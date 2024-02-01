//
//  Images+.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 25/01/24.
//

import UIKit

extension DesignSystem.Images {
    static var backButton: UIImage = UIImage(named: "Icons/ArrowLeft")!
    
    static var mockImageCell: UIImage = UIImage(named: "Images/MockCellImage")!
    
    static var notFoundImage: UIImage = UIImage(named: "Images/NotFound")!
    
    static var arrowRight: UIImage = UIImage(named: "Icons/ArrowRight")!
    
    static var searchIcon: UIImage = UIImage(named: "Icons/Search")!
    
    static var heartIcon: UIImage = UIImage(
        systemName: "suit.heart"
    ) ?? UIImage(systemName: "heart")!
    
    static var heartIconFill: UIImage = UIImage(
        systemName: "suit.heart.fill"
    ) ?? UIImage(systemName: "heart.fill")!
}
