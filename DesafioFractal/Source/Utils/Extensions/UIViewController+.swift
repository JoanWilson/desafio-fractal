//
//  UIViewController+.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 01/02/24.
//

import UIKit

extension UIViewController {
    func showErrorAlert(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func showAlertWithAction(title: String, message: String, action: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { _ in
            action()
        }
        
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
