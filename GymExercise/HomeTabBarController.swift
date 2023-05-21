//
//  HomeTabBarController.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-16.
//

import UIKit

class HomeTabBarController: UITabBarController {

    //for profile view
    let userData: UserData

    init(userData: UserData) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        
        navigationItem.hidesBackButton = true
        
        super.viewDidLoad()
        
        print("Passed userData: \(userData)")
        
        let homeVC = HomeViewController(userData: userData)
        let searchVC = SearchViewController(userData: userData)
        let favoritesVC = FavoritesViewController(userData: userData)
        let profileVC = ProfileViewController(userData: userData)

        viewControllers = [homeVC, searchVC, favoritesVC, profileVC]

        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)

        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: nil)
        searchVC.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(named: "calendar"), selectedImage: nil)
        favoritesVC.tabBarItem = UITabBarItem(title: "MyPlan", image: UIImage(named: "report"), selectedImage: nil)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "settings"), selectedImage: nil)
    }
    
}

