//
//  Fonts+.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 25/01/24.
//

import UIKit

extension DesignSystem.Tokens.Fonts {
    
    static func montserratMedium(_ size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: FontsEnum.montserratMedium(), size: size) else {
            print("\(FontsEnum.montserratMedium()) couldn't be found")
            return UIFont.systemFont(ofSize: size)
        }
        
        return customFont
    }
    
    static func montserratSemiBold(_ size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: FontsEnum.montserratSemiBold(), size: size) else {
            print("\(FontsEnum.montserratSemiBold()) couldn't be found")
            return UIFont.systemFont(ofSize: size)
        }
        
        return customFont
    }
    
    static func montserratBold(_ size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: FontsEnum.montserratBold(), size: size) else {
            print("\(FontsEnum.montserratBold()) couldn't be found")
            return UIFont.systemFont(ofSize: size)
        }
        
        return customFont
    }
    
}
