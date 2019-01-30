import Alamofire
import RxAlamofire
import RxSwift

final class Network<T: Codable> {

    private let baseURL: String
    private let scheduler: ConcurrentDispatchQueueScheduler

    init(_ baseURL: String = CoreConfig.BASE_URL) {
        self.baseURL = baseURL
        self.scheduler = ConcurrentDispatchQueueScheduler(
            qos: DispatchQoS(
                qosClass: DispatchQoS.QoSClass.background,
                relativePriority: 1
            )
        )
    }

    func dicoverMovie(_ path: String, parameters: [String: Any]) -> Single<T> {
        let absolutePath: String = "\(baseURL)/\(path)"
        return RxAlamofire
            .data(
                .get,
                absolutePath,
                parameters: parameters,
                encoding: URLEncoding()
            )
            .debug()
            .asSingle()
            .observeOn(scheduler)
            .map(T.self)
    }
}
