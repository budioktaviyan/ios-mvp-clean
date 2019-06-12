import RxSwift

class HomePresenter {

    private let usecase: HomeUsecase

    private weak var view: HomeView?

    init(usecase: HomeUsecase) {
        self.usecase = usecase
    }

    deinit {
        usecase.dispose()
    }

    func onAttach(view: HomeView) {
        self.view = view
    }

    func discoverMovie(params: HomeParam) {
        view?.onShowLoading()
        usecase.execute(singleObserver: HomeUsecaseObserver(withView: view), params: params)
    }

    func discoverMoreMovie() {
        // TODO: Load more movie here using pagination
    }
}

fileprivate class HomeUsecaseObserver: DefaultObserver<HomeEntity> {

    private weak var view: HomeView?

    init(withView: HomeView?) {
        self.view = withView
    }

    override func onEvent(event: SingleEvent<HomeEntity>) {
        switch event {
        case .success(let entity):
            view?.onHideLoading()
            view?.onShowDiscoverMovie(entity: entity)
        case .error(let error):
            view?.onHideLoading()
            view?.onShowErrorMessage(message: error.localizedDescription)
        }
    }
}
