import UIKit

protocol AppRouterDelegate {

    func presentView(controller: UIViewController)
}

class AppRouter: AppRouterDelegate {

    static let instance: AppRouter = AppRouter.create()

    private let navigation: UINavigationController?

    init(navigation: UINavigationController?) {
        self.navigation = navigation
        self.navigation?.isNavigationBarHidden = false
    }

    func presentView(controller: UIViewController) {
        navigation?.pushViewController(controller, animated: true)
    }

    private static func create() -> AppRouter {
        let root: UINavigationController? = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController
        let router: AppRouter = AppRouter(navigation: root)

        return router
    }
}
