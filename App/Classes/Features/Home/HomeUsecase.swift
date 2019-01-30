import RxSwift

class HomeUsecase: Usecase<HomeEntity, HomeParam> {

    private let repository: HomeRepository

    init(repository: HomeRepository,
         executor: JobExecutor,
         thread: UIThread) {
        self.repository = repository
        super.init(jobExecutor: executor, uiThread: thread)
    }

    override func buildUsecaseObservable(params: HomeParam) -> PrimitiveSequence<SingleTrait, HomeEntity> {
        return repository.discoverMovie(withParam: params)
    }
}
