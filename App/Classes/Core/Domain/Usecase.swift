import RxSwift

class Usecase<T, Params> {

    private let jobExecutor: JobExecutor
    private let uiThread: UIThread
    private let disposables: CompositeDisposable = CompositeDisposable()

    init(jobExecutor: JobExecutor,
         uiThread: UIThread) {
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
        let disposable: Disposable = single.subscribe { event in
            return singleObserver.onEvent(event: event)
        }

        addDisposable(disposable: disposable)
    }

    func dispose() {
        disposables.dispose()
        disposables.disposed(by: DisposeBag())
    }

    private func addDisposable(disposable: Disposable) {
        _ = disposables.insert(disposable)
    }
}
