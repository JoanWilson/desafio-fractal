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
    
    func showLoadingAnimation() {
        
        let backgroundView = UIView()
        backgroundView.tag = 212121
        backgroundView.backgroundColor = .black.withAlphaComponent(0.6)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        let loadingView = UIActivityIndicatorView(style: .large)
        loadingView.tag = 222222
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            self.view.addSubview(backgroundView)
            backgroundView.addSubview(loadingView)
            self.view.bringSubviewToFront(backgroundView)
            
            NSLayoutConstraint.activate([
                backgroundView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width),
                backgroundView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height),
                backgroundView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                backgroundView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                loadingView.widthAnchor.constraint(equalToConstant: 60),
                loadingView.heightAnchor.constraint(equalToConstant: 60),
                loadingView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
                loadingView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
            ])
        }
        
        loadingView.startAnimating()
    }
    
    func hideLoadingAnimation() {
        if let background = view.viewWithTag(212121) {
            background.removeFromSuperview()
        }
    }
}
