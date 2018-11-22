import RxSwift

class Usecase<T, Params> {

    private var jobExecutor: JobExecutor
    private var uiThread: UIThread

    private let disposables: CompositeDisposable = CompositeDisposable()

    init(jobExecutor: JobExecutor, uiThread: UIThread) {
        self.jobExecutor = jobExecutor
        self.uiThread = uiThread
    }
}
