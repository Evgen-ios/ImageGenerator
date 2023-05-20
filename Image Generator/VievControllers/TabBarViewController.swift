//
//  TabBarViewController.swift
//  Image Generator
//
//  Created by Evgeniy Goncharov on 20.05.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Private Lazy Properties
    private lazy var main = UINavigationController(rootViewController: MainViewController().apply {
        $0.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "house"), selectedImage: UIImage(named: "house.fill"))
    })
    
    private lazy var favorite = UINavigationController(rootViewController: FavoriteViewController().apply {
        $0.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "star"), selectedImage: UIImage(named: "star.fill"))
    })
    
    // MARK: - Inherited Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    // MARK: - Methods
    private func setupViews() {
        viewControllers = [main, favorite]
    }
}
