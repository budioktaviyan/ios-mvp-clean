import UIKit
import Swinject

protocol AppRouterDelegate {

    var resolver: Resolver { get }

    func presentModule(module: AppModule)
    func presentView(controller: UIViewController)
}

class AppRouter: AppRouterDelegate {

    static let instance: AppRouter = AppRouter.create()

    private let assembler: Assembler
    private let navigation: UINavigationController?

    init(assembler: Assembler,
         navigation: UINavigationController?) {
        self.assembler = assembler
        self.navigation = navigation
        self.navigation?.isNavigationBarHidden = false
    }

    var resolver: Resolver { return assembler.resolver }

    func presentModule(module: AppModule) {
        module.presentView()
    }

    func presentView(controller: UIViewController) {
        navigation?.pushViewController(controller, animated: true)
    }

    private static func create() -> AppRouter {
        let assembler: Assembler = Assembler()
        assembler.apply(
            assemblies: [
                AppAssembly(),
                HomeAssembly()
            ]
        )

        let root: UINavigationController? = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController
        let router: AppRouter = AppRouter(assembler: assembler, navigation: root)

        return router
    }
}
