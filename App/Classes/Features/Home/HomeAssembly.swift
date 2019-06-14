import Swinject

class HomeAssembly: Assembly {

    func assemble(container: Container) {
        container.register(Network.self) { _ in
            return Network<HomeResponse>()
        }

        container.register(HomeDatasource.self) {(r, router: AppRouter) in
            let datasource: HomeDatasource = HomeDatasource()
            let network: Network<HomeResponse> = r.resolve(Network.self)!
            datasource.network = network

            return datasource
        }

        container.register(HomeFactory.self) {(r, router: AppRouter) in
            let datasource: HomeDatasource = r.resolve(HomeDatasource.self, argument: router)!
            return HomeFactory(datasource: datasource)
        }

        container.register(HomeRepository.self) {(r, router: AppRouter) in
            let factory: HomeFactory = r.resolve(HomeFactory.self, argument: router)!
            return HomeRepository(factory: factory)
        }

        container.register(HomeUsecase.self) {(r, router: AppRouter) in
            let repository: HomeRepository = r.resolve(HomeRepository.self, argument: router)!
            let executor: JobExecutor = r.resolve(JobExecutor.self)!
            let thread: UIThread = r.resolve(UIThread.self)!

            return HomeUsecase(
                repository: repository,
                executor: executor,
                thread: thread
            )
        }

        container.register(HomePresenter.self) {(r, router: AppRouter, view: HomeView) in
            let usecase: HomeUsecase = r.resolve(HomeUsecase.self, argument: router)!
            return HomePresenter(
                view: view,
                usecase: usecase
            )
        }

        container.register(HomeController.self) {(r, router: AppRouter) in
            let view: HomeController = HomeController()
            let presenter: HomePresenter = r.resolve(HomePresenter.self, arguments: router, view as HomeView)!
            view.presenter = presenter

            return view
        }
    }
}
