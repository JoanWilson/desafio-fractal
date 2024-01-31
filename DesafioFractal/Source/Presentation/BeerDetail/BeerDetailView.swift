//
//  BearDetailView.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 29/01/24.
// swiftlint: disable line_length

import UIKit

final class BeerDetailView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = DesignSystem.Colors.white
        scrollView.contentSize = UIScreen.main.bounds.size
        
        return scrollView
    }()
    
    lazy var beerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = DesignSystem.Images.mockImageCell
        imageView.heightAnchor.constraint(equalToConstant: 74).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 74).isActive = true
        
        return imageView
    }()
    
    lazy var beerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AB: 01"
        label.font = DesignSystem.Fonts.montserratSemiBold(24)
        label.textColor = DesignSystem.Colors.gray
        
        return label
    }()
    
    lazy var beerSubTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Triple Dry Hopped Imperial Red."
        label.font = DesignSystem.Fonts.montserratSemiBold(12)
        label.textColor = DesignSystem.Colors.gray
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.spacing = 6
        
        return stack
    }()
    
    lazy var headerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        stack.alignment = .center
        
        return stack
    }()
    
    lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        label.font = DesignSystem.Fonts.montserratMedium(14)
        label.textColor = DesignSystem.Colors.lightGray
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 33
        
        return stackView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buildLayout()
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(handleOrientationChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        descriptionText.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.9).isActive = true
        headerStack.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc func handleOrientationChange() {
        descriptionText.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.9).isActive = true
        headerStack.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    private func setupView() {
        self.backgroundColor = DesignSystem.Colors.secondary
    }
}

extension BeerDetailView: ViewCoding {
    func setupHierarchy() {
        
        labelsStack.addArrangedSubview(beerTitle)
        labelsStack.addArrangedSubview(beerSubTitle)
    
        headerStack.addArrangedSubview(beerImage)
        headerStack.addArrangedSubview(labelsStack)
        
        containerStack.addArrangedSubview(headerStack)
        containerStack.addArrangedSubview(descriptionText)
    
        scrollView.addSubview(containerStack)
        
        self.addSubview(scrollView)
    }
    
    func setupConstraints() {
        scrollViewConstraints()
        containerStackConstraints()
    }
    
    private func scrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func containerStackConstraints() {
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 27),
            containerStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16)
        ])
    }
    
}
