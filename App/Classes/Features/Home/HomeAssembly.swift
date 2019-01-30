import Swinject

class HomeAssembly: Assembly {

    func assemble(container: Container) {
        container.register(HomeDatasource.self) { _ in
            return HomeDatasource()
        }

        container.register(HomeFactory.self) { r in
            let datasource: HomeDatasource = r.resolve(HomeDatasource.self)!
            return HomeFactory(datasource: datasource)
        }

        container.register(HomeRepository.self) { r in
            let factory: HomeFactory = r.resolve(HomeFactory.self)!
            return HomeRepository(factory: factory)
        }

        container.register(HomeUsecase.self) { r in
            let repository: HomeRepository = r.resolve(HomeRepository.self)!
            let executor: JobExecutor = r.resolve(JobExecutor.self)!
            let thread: UIThread = r.resolve(UIThread.self)!

            return HomeUsecase(
                repository: repository,
                executor: executor,
                thread: thread
            )
        }

        container.register(HomePresenter.self) { r in
            let usecase: HomeUsecase = r.resolve(HomeUsecase.self)!
            return HomePresenter(usecase: usecase)
        }
    }
}
