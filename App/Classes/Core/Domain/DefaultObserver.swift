import RxSwift

class DefaultObserver<T>: ObserverType {

    typealias E = T

    func on(_ event: Event<T>) {
        onEvent(event: event)
    }

    func onEvent(event: Event<T>) {}
}
