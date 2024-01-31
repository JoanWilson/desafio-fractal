//
//  BeerDetailViewController.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 29/01/24.
//

import UIKit

class BeerDetailViewController: UIViewController {
    private var contentView: BeerDetailView = .init()
    private var viewModel: BeerDetailViewModel
    
    private lazy var favoriteButton: UIBarButtonItem = {
        let searchButton = UIBarButtonItem(
            image: DesignSystem.Images.heartIcon,
            style: .plain,
            target: self,
            action: #selector(favoriteBeer)
        )
        
        searchButton.tintColor = DesignSystem.Colors.whiteFont
        
        return searchButton
    }()
    
    init(viewModel: BeerDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Beer Details"
        setupNavigationBar()
    }
}

extension BeerDetailViewController {
    public func configureBeerDetail(with beer: Beer) {
        if let beerImageURL = URL(string: beer.imageURL!) {
            contentView.beerImage.load(url: beerImageURL)
        }
        
        contentView.beerTitle.text = beer.name
        contentView.beerSubTitle.text = beer.tagline
        contentView.descriptionText.text = beer.description
    }
}

extension BeerDetailViewController {
    private func setupNavigationBar() {
        modifyNavigationBarStyling()
        addFavoriteButton()
    }
    
    private func modifyNavigationBarStyling() {
        let navigationbarAppearance = UINavigationBarAppearance()
        
        navigationbarAppearance.backgroundColor = DesignSystem.Colors.primary
        let montserratFont: UIFont = DesignSystem.Fonts.montserratSemiBold(20)
        navigationbarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: DesignSystem.Colors.whiteFont,
            NSAttributedString.Key.font: montserratFont
        ]
        
        self.navigationController?.navigationBar.standardAppearance = navigationbarAppearance
        self.navigationController?.navigationBar.backgroundColor = DesignSystem.Colors.primary
        self.navigationController?.navigationBar.tintColor = DesignSystem.Colors.whiteFont
        
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    private func addFavoriteButton() {
        self.navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc private func favoriteBeer() {
        if !viewModel.isFavorite {
            favoriteButton.image = DesignSystem.Images.heartIconFill
            viewModel.isFavorite =  true
        } else {
            favoriteButton.image = DesignSystem.Images.heartIcon
            viewModel.isFavorite = false
        }
    }
}
