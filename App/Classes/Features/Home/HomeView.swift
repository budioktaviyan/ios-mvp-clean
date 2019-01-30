protocol HomeView: class {

    func onShowLoading()
    func onHideLoading()
    func onShowDiscoverMovie(entity: HomeEntity)
    func onShowErrorMessage(message: String)
}
