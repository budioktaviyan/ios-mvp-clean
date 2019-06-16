import UIKit

class DetailController: DatasourceController {

    var entity: DetailEntity!
    var presenter: DetailPresenter!

    private lazy var datasources: DetailViewDatasource = DetailViewDatasource()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: nil,
            style: UIBarButtonItem.Style.plain,
            target: nil,
            action: nil
        )
        self.collectionView?.backgroundColor = .white
        self.datasource = datasources

        presenter.discoverMovie(entity: entity)
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 256)
    }
}

extension DetailController: DetailView {

    func onShowDiscoverMovie(entity: DetailEntity) {
        self.title = entity.title
        datasources.entity = entity
        datasources.objects = [entity]
    }
}
