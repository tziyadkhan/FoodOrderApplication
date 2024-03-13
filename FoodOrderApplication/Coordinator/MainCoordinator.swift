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

    func showHomePage() {
      let controller = TabBarController()
      controller.coordinator = self
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
    
    func showMeals() {
        let controller = MealsPageController()
        controller.coordinator = self
        navigationController.show(controller, sender: nil)
    }
}
