//
//  HomeTabBarController.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-16.
//

import UIKit

class HomeTabBarController: UITabBarController {

    let userData: UserData

    init(userData: UserData) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Passed userData: \(userData)")
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let favoritesVC = FavoritesViewController()
        let profileVC = ProfileViewController(userData: userData)

        viewControllers = [homeVC, searchVC, favoritesVC, profileVC]

        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor.red

        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home_icon"), selectedImage: nil)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search_icon"), selectedImage: nil)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorites_icon"), selectedImage: nil)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_icon"), selectedImage: nil)
    }
    
}

