import RxSwift

protocol HomeDatasourceDelegate {

    associatedtype T: Codable

    func discoverMovie(withParam: HomeParam) -> Single<T>
}

class HomeDatasource: HomeDatasourceDelegate {

    typealias T = HomeResponse

    private lazy var network = AppContainer.instance.resolve(type: Network<T>.self)

    func discoverMovie(withParam: HomeParam) -> PrimitiveSequence<SingleTrait, HomeResponse> {
        return network.dicoverMovie(
            CoreConfig.Module.Movies.DISCOVER,
            parameters: withParam.request.nullKeyRemoval()
        )
    }
}
