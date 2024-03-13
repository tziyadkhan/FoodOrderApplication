//
//  TabBarController.swift
//  FoodOrderApplication
//
//  Created by Ziyadkhan on 11.03.24.
//

import UIKit

class TabBarController: UITabBarController {
    
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
    
    func configureTabBar() {
        
        //MARK: Home Page
        let homeController = HomePageController()
        homeController.tabBarItem = .init(title: "Home",
                                             image: UIImage(named: "Home"),
                                             tag: 0)
        homeController.title = "Home"
        let homeNavigation = UINavigationController(rootViewController: homeController)
        
        //MARK: Basket Page
        let basketController = BasketPageController()
        basketController.tabBarItem = .init(title: "Basket",
                                             image: UIImage(named: "Cart"),
                                             tag: 0)
        basketController.title = "Basket"
        let basketNavigation = UINavigationController(rootViewController: basketController)
        
        UITabBar.appearance().backgroundColor = .white
        viewControllers = [homeNavigation, basketNavigation]
    }

}
