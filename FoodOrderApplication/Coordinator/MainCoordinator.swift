//
import UIKit

class MainCoordinator: Coordinator {
    
    var onLogin: ((String, String) -> Void)?
    var navigationController: UINavigationController
        var window: UIWindow?
    
    init(onLogin: ((String, String) -> Void)? = nil, navigationController: UINavigationController) {
        self.onLogin = onLogin
        self.navigationController = navigationController
    }
    func start() {
        let controller = LoginPageController()
        controller.coordinator = self
        navigationController.show(controller, sender: nil)
    }
    
    func showRegistration() {
        let controller = RegistrationPageController()
        controller.onLogin = onLogin
        controller.coordinator = self
        navigationController.show(controller, sender: nil)
    }
    
    //    func showHomePage() {
    //      let controller = TabBarController()
    //      controller.coordinator = self
    //      navigationController.show(controller, sender: nil)
    //    }
    
    func showHomePage() {
        let homeController = HomePageController()
        homeController.coordinator = self
        let homeNavigation = UINavigationController(rootViewController: homeController)
        homeController.title = "Home"

        homeController.tabBarItem = .init(title: "Home",
                                          image: UIImage(named: "Home"),
                                          tag: 0)
        
        let basketController = BasketPageController()
        basketController.coordinator = self
        let basketNavigation = UINavigationController(rootViewController: basketController)
        basketController.title = "Basket"

        basketController.tabBarItem = .init(title: "Basket",
                                            image: UIImage(named: "Cart"),
                                            tag: 0)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let controller = TabBarController()
        controller.coordinator = self
        controller.viewControllers = [homeNavigation, basketNavigation]
        
        window?.rootViewController = controller
        window?.makeKeyAndVisible()

        UITabBar.appearance().backgroundColor = .white
        navigationController.show(controller, sender: nil)
    }
    
    func showBasketPage() {
        let controller = BasketPageController()
        controller.coordinator = self
        navigationController.show(controller, sender: nil)
    }
    
    func showRestaurantInfo(data: RestaurantModel) {
        let controller = RestaurantInfoController()
        controller.coordinator = self
        controller.fillData(data: data)
        navigationController.show(controller, sender: nil)
    }
    
    func showMeals(meals: [MealModel]) {
        let controller = MealsPageController()
        controller.coordinator = self
        controller.foodList = meals
        navigationController.show(controller, sender: nil)
    }
}
