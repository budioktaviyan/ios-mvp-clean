class HomeModule: AppModule {

    let router: AppRouter

    init(router: AppRouter) {
        self.router = router
    }

    func presentView() {
        let controller: HomeController = router.resolver.resolve(HomeController.self, argument: router)!
        router.presentView(controller: controller)
    }
}
