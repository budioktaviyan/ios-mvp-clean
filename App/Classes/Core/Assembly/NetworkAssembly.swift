import Swinject

class NetworkAssembly: Assembly {

    func assemble(container: Container) {
        container.register(Network.self) { _ in
            return Network<HomeResponse>()
        }
    }
}
