//
//  PageCell.swift
//  CollectionViewTest
//
//  Created by Adrián Silva on 25/1/18.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {

    var page: Page? {
        didSet{

            guard let unwrappedPage = page else { return }
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])

            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bottomText)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)]))

            topImageView.image = UIImage(named: unwrappedPage.imageName)
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }



    let topImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "wifi-signal"))
        // enables autolayout for the imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false

        let attributedText = NSMutableAttributedString(string: "Necesitas acceso a internet para jugar", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])

        attributedText.append(NSAttributedString(string: "\n\n\nPor favor acepta los permisos", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)]))

        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    private func setupLayout() {




        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        topImageContainerView.addSubview(topImageView)

        topImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        topImageView.topAnchor.constraint(equalTo: topImageContainerView.topAnchor, constant: 100).isActive = true
        topImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        topImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 120).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true



    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
}

