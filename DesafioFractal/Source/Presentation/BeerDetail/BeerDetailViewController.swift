//
//  BeerDetailViewController.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 29/01/24.
//

import UIKit

final class BeerDetailViewController: UIViewController {
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
        addBinders()
    }
    
    private func addBinders() {
        viewModel.$isFavorite.sink { [weak self] isFavorite in
            guard let self else { return }
            
            DispatchQueue.main.async {
                if isFavorite {
                    self.favoriteButton.image = DesignSystem.Images.heartIconFill
                } else {
                    self.favoriteButton.image = DesignSystem.Images.heartIcon
                }
            }
        }.store(in: &viewModel.cancellable)
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
            let imageData = contentView.beerImage.image?.jpegData(compressionQuality: 1.0) ??
            DesignSystem.Images.mockImageCell.jpegData(compressionQuality: 1.0)!
            let dto = viewModel.makeDTOWithImageData(imageData: imageData)
            favoriteBeerAction(dto: dto)
        } else {
            unfavoriteBeerAction(id: self.viewModel.beer.id)
        }
    }
    
    private func favoriteBeerAction(dto: FavoriteBeerDTO) {
        DispatchQueue.global().async {
            if self.viewModel.favoriteBeer(dto: dto) {
                DispatchQueue.main.async {
                    self.favoriteButton.image = DesignSystem.Images.heartIconFill
                    self.viewModel.isFavorite =  true
                }
            } else {
                self.showErrorAlert(errorMessage: "Failed to mark this beer as favorite")
            }
        }
        
    }
    
    private func unfavoriteBeerAction(id: Int) {
        DispatchQueue.global().async {
            if self.viewModel.unfavoriteBeer(id: id) {
                DispatchQueue.main.async {
                    self.favoriteButton.image = DesignSystem.Images.heartIcon
                    self.viewModel.isFavorite = false
                }
            } else {
                self.showErrorAlert(errorMessage: "Failed to remove this beer as favorite")
            }
        }
    }
}
