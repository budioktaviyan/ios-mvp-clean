import UIKit

class HomeController: UIViewController {

    private lazy var presenter: HomePresenter = AppContainer.instance.resolve(type: HomePresenter.self)

    override func viewDidLoad() {
        super.viewDidLoad()

        let params: HomeParam = HomeParam(apiKey: CoreConfig.API_KEY)
        presenter.onAttach(view: self)
        presenter.discoverMovie(params: params)
    }
}

extension HomeController: HomeView {

    func onShowLoading() {}

    func onHideLoading() {}

    func onShowDiscoverMovie(entity: HomeEntity) {
        guard let title = entity.movies.first?.title else { return }
        print(title)
    }

    func onShowErrorMessage(message: String) {}
}
