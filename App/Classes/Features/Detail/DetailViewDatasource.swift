import UIKit

class DetailViewDatasource: Datasource {

    var entity: DetailEntity?

    override func numberOfItems(_ section: Int) -> Int {
        return objects?.count ?? 1
    }

    override func headerItem(_ section: Int) -> Any? {
        return entity ?? nil
    }

    override func item(_ indexPath: IndexPath) -> Any? {
        return objects?[indexPath.item]
    }

    override func headerClasses() -> [DatasourceCell.Type]? {
        return [DetailHeaderCell.self]
    }

    override func cellClasses() -> [DatasourceCell.Type] {
        return [DetailViewCell.self]
    }

    override func cellClass(_ indexPath: IndexPath) -> DatasourceCell.Type? {
        return DetailViewCell.self
    }
}
