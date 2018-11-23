import UIKit

protocol AppRouterDelegate {

    func presentView(controller: UIViewController)
}

class AppRouter: AppRouterDelegate {

    static let instance: AppRouter = AppRouter.create()

    private var navigation: UINavigationController?

    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }

    static func launch(with window: UIWindow?, controller: UIViewController) {
        window?.rootViewController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
    }

    func presentView(controller: UIViewController) {
        navigation?.pushViewController(controller, animated: true)
    }

    private static func create() -> AppRouter {
        let root = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
        return AppRouter(navigation: root)
    }
}
