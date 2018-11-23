import RxSwift

class Usecase<T, Params> {

    private var jobExecutor: JobExecutor
    private var uiThread: UIThread

    private let disposables: CompositeDisposable = CompositeDisposable()

    init(jobExecutor: JobExecutor, uiThread: UIThread) {
        self.jobExecutor = jobExecutor
        self.uiThread = uiThread
    }

    func buildUsecaseObservable(params: Params) -> Single<T> {
        return Single.never()
    }

    func execute(singleObserver: DefaultObserver<T>, params: Params) {
        let single: Single<T> = buildUsecaseObservable(params: params)
            .subscribeOn(jobExecutor.getSchedulerType())
            .observeOn(uiThread.getSchedulerType())
        addDisposable(disposable: single.subscribe { singleObserver in })
    }

    func dispose() {
        disposables.dispose()
        disposables.disposed(by: DisposeBag())
    }

    private func addDisposable(disposable: Disposable) {
        _ = disposables.insert(disposable)
    }
}
