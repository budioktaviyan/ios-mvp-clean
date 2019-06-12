import UIKit

class HomeController: DatasourceController {

    private lazy var params: HomeParam = HomeParam(apiKey: CoreConfig.API_KEY)
    private lazy var presenter: HomePresenter = AppContainer.instance.resolve(type: HomePresenter.self)
    private lazy var datasources: HomeViewDatasource = HomeViewDatasource()
    private lazy var loadingView: LoadingView = LoadingView()
    private lazy var errorView: LoadingErrorView = {
        let view = LoadingErrorView()
        view.delegate = self

        return view
    }()

    private var isLoading: Bool = false
    private var isLoadMore: Bool = false
    private var currentPage: Int64 = 0 { didSet {self.checkCurrentPage()} }
    private var totalPage: Int64 = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: nil,
            style: UIBarButtonItem.Style.plain,
            target: nil,
            action: nil
        )
        self.collectionView?.backgroundColor = .white
        self.datasource = datasources

        presenter.onAttach(view: self)
        presenter.discoverMovie(params: params)
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        switch elementKind {
        case UICollectionView.elementKindSectionFooter:
            switch datasources.isLoadMoreError {
            case false:
                guard let view = view as? LoadingMoreView else { return }
                view.indicator.startAnimating()
            default:
                guard let view = view as? LoadingMoreErrorView else { return }
                view.delegate = self
            }
        default:
            break
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let objects = datasources.objects else { return }
        guard let _ = objects[indexPath.row] as? Movie else { return }
        // TODO: Construct movie data to the next detail movie screen
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if (currentOffsetY == maximumOffset) && currentPage + 1 <= totalPage && !isLoading { presenter.discoverMoreMovie() }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch isLoadMore {
        case false:
            return CGSize(width: view.frame.width, height: 0)
        default:
            return CGSize(width: view.frame.width, height: 50)
        }
    }
}

extension HomeController: LoadingErrorDelegate, LoadingMoreErrorDelegate {

    func onRetryClicked() {
        errorView.isHidden = true
        errorView.removeFromSuperview()
        presenter.discoverMovie(params: params)
    }

    func onRetryMoreClicked() {
        datasources.isLoadMoreError = false
        reloadData()
        presenter.discoverMoreMovie()
    }

    private func initLoadView() {
        view.addSubview(loadingView)
        loadingView.anchor(
            view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 0
        )
    }

    private func initLoadErrorView() {
        view.addSubview(errorView)
        errorView.anchor(
            view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 0
        )
    }
}

extension HomeController: HomeView {

    func onShowLoading() {
        initLoadView()
        loadingView.show()
    }

    func onHideLoading() {
        loadingView.hide()
    }

    func onShowDiscoverMovie(entity: HomeEntity) {
        datasources.objects = entity.movies
        totalPage = entity.page
        currentPage = 1
    }

    func onShowErrorMessage(message: String) {
        initLoadErrorView()
        errorView.isHidden = false
        print(message)
    }

    private func checkCurrentPage() {
        isLoadMore = currentPage < totalPage
    }

    private func reloadData() {
        collectionView?.reloadData()
    }
}
