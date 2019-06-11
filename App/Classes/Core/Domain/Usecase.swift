import RxSwift

protocol Usecase {

    associatedtype T
    associatedtype Params

    var jobExecutor: JobExecutor { get }
    var uiThread: UIThread { get }
    var disposables: CompositeDisposable { get }

    func buildUsecaseObservable(params: Params) -> Single<T>
}

extension Usecase {

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

        _ = disposables.insert(disposable)
    }

    func dispose() {
        disposables.dispose()
        disposables.disposed(by: DisposeBag())
    }
}
