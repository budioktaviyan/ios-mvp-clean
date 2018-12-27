import UIKit
import Swinject

protocol AppRouterDelegate {

    func presentView(controller: UIViewController)
}

class AppRouter: AppRouterDelegate {

    static let instance: AppRouter = AppRouter.create()

    private let navigation: UINavigationController?
    private let assembler: Assembler

    init(navigation: UINavigationController?, assembler: Assembler) {
        self.navigation = navigation
        self.assembler = assembler
    }

    func presentView(controller: UIViewController) {
        navigation?.pushViewController(controller, animated: true)
    }

    private static func create() -> AppRouter {
        let root: UINavigationController? = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController

        let assembler: Assembler = Assembler()
        assembler.apply(assemblies: [AppAssembly()])

        let router = AppRouter(navigation: root, assembler: assembler)
        return router
    }
}
