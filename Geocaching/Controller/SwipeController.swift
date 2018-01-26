//
//  SwipeController.swift
//  CollectionViewTest
//
//  Created by Adrián Silva on 25/1/18.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

struct Page {

    let imageName: String
    let headerText: String
    let bottomText: String

}

extension UIColor {
    static var customGreen = UIColor(red: 95/255, green: 142/255, blue: 40/255, alpha: 1)
}

class SwipeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let pages = [
        Page(imageName: "wifi-signal", headerText: "Necesitas acceso a internet para jugar", bottomText: "Por favor acepta los permisos"),
        Page(imageName: "globe", headerText: "Necesitas usar la geolocalización para ubicarte", bottomText: "Por favor acepta los permisos")
    ]

    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)

        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.customGreen, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()

    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .customGreen
        pc.pageIndicatorTintColor = UIColor(red: 183/255, green: 232/255, blue: 201/255, alpha: 1)
        return pc
    }()

    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SKIP", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = .white

        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")

        // allows to paginate the views inside the collectionView
        collectionView?.isPagingEnabled = true

        setupButtonControls()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width, height: view.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    fileprivate func setupButtonControls() {

        let topSkipButtonContainerView = UIView()
        view.addSubview(topSkipButtonContainerView)
        topSkipButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        topSkipButtonContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        topSkipButtonContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topSkipButtonContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        topSkipButtonContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true

        topSkipButtonContainerView.addSubview(skipButton)

        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.trailingAnchor.constraint(equalTo: topSkipButtonContainerView.trailingAnchor).isActive = true
        skipButton.topAnchor.constraint(equalTo: topSkipButtonContainerView.topAnchor).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl,  nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomControlsStackView)
        bottomControlsStackView.distribution = .fillEqually

        bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    @objc func handleSkip() {
        performSegue(withIdentifier: "fromCollectionToTab", sender: self)
    }

    @objc func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    @objc func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let x = targetContentOffset.pointee.x

        pageControl.currentPage = Int(x/view.frame.width)
    }


}

