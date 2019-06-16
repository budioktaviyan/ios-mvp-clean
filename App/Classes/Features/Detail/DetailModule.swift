class DetailModule: AppModule {

    let router: AppRouter
    let entity: DetailEntity

    init(router: AppRouter,
         entity: DetailEntity) {
        self.router = router
        self.entity = entity
    }

    func presentView() {
        let controller: DetailController = router.resolver.resolve(DetailController.self, argument: router)!
        controller.entity = entity
        router.presentView(controller: controller)
    }
}
