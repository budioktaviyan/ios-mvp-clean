import RxSwift

class HomeUsecase: Usecase {

    private let repository: HomeRepository
    private let executor: JobExecutor
    private let thread: UIThread

    init(repository: HomeRepository,
         executor: JobExecutor,
         thread: UIThread) {
        self.repository = repository
        self.executor = executor
        self.thread = thread
    }

    var jobExecutor: JobExecutor { return executor }
    var uiThread: UIThread { return thread }
    var disposables: CompositeDisposable { return CompositeDisposable() }
}

extension HomeUsecase {

    func buildUsecaseObservable(params: HomeParam) -> Single<HomeEntity> {
        return repository.discoverMovie(withParam: params)
    }
}
