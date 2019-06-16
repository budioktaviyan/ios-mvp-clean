import Swinject

class DetailAssembly: Assembly {

    func assemble(container: Container) {
        container.register(DetailPresenter.self) {(r, router: AppRouter, view: DetailView) in
            return DetailPresenter(view: view)
        }

        container.register(DetailController.self) {(r, router: AppRouter) in
            let view: DetailController = DetailController()
            let presenter: DetailPresenter = r.resolve(DetailPresenter.self, arguments: router, view as DetailView)!
            view.presenter = presenter

            return view
        }
    }
}
