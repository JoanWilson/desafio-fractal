//
//  ViewController.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 25/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = DesignSystem.Tokens.Colors.secondary
        title = "aqui"
//        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
//        navigationController?.navigationBar.backItem?.title = ""
        
    }
    

}
