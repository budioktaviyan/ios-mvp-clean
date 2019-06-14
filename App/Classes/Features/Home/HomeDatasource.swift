import RxSwift

protocol HomeDatasourceDelegate {

    associatedtype T: Codable

    func discoverMovie(withParam: HomeParam) -> Single<T>
}

class HomeDatasource: HomeDatasourceDelegate {

    typealias T = HomeResponse

    var network: Network<T>!

    func discoverMovie(withParam: HomeParam) -> PrimitiveSequence<SingleTrait, HomeResponse> {
        return network.dicoverMovie(
            CoreConfig.Module.Movies.DISCOVER,
            parameters: withParam.request.nullKeyRemoval()
        )
    }
}
