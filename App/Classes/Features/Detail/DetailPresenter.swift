class DetailPresenter {

    weak var view: DetailView?

    init(view: DetailView) {
        self.view = view
    }

    func discoverMovie(entity: DetailEntity) {
        view?.onShowDiscoverMovie(entity: entity)
    }
}
