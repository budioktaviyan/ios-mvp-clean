protocol HomeView: class {

    func onShowLoading()
    func onHideLoading()
    func onLoadMore()
    func onShowDiscoverMovie(entity: HomeEntity)
    func onShowDiscoverMovies(entity: HomeEntity)
    func onShowErrorMessage(message: String)
    func onShowErrorMessages(message: String)
}
