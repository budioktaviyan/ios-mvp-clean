import Swinject

class AppContainer {

    static let instance: AppContainer = AppContainer()

    private let assembler: Assembler = Assembler()

    func resolve<T>(type: T.Type) -> T {
        return assembler.resolver.resolve(type)!
    }

    func resolve<T, Args>(_ type: T.Type, argument: Args) -> T {
        return assembler.resolver.resolve(type, argument: argument)!
    }

    func inject() {
        assembler.apply(
            assemblies: [
                AppAssembly(),
                NetworkAssembly(),
                HomeAssembly()
            ]
        )
    }
}
