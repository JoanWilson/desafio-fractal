//
//  FontsEnum.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 25/01/24.
//

import Foundation

enum FontsEnum: String {
    case montserratMedium = "Montserrat-Medium"
    case montserratSemiBold = "Montserrat-SemiBold"
    case montserratBold = "Montserrat-Bold"
    
    func callAsFunction() -> String {
        return self.rawValue
    }
}
