import UIKit
import Kingfisher

class DetailHeaderCell: DatasourceCell {

    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit

        return view
    }()

    override var datasource: Any? {
        didSet {
            guard let data = datasource as? DetailEntity else { return }
            image.loadAndResize(url: data.backdropPath, view: self)
        }
    }

    override func setupViews() {
        addSubview(image)
        image.anchor(
            safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            bottom: nil,
            right: rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 0
        )
    }
}

class DetailViewCell: DatasourceCell {

    private lazy var label: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .black
        view.textAlignment = .left
        view.numberOfLines = 0
        view.sizeToFit()

        return view
    }()

    override var datasource: Any? {
        didSet {
            guard let data = datasource as? DetailEntity else { return }
            label.text = data.overview
        }
    }

    override func setupViews() {
        backgroundColor = .white
        addSubview(label)
        label.anchor(
            safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            bottom: nil,
            right: rightAnchor,
            topConstant: -24,
            leftConstant: 8,
            bottomConstant: 0,
            rightConstant: 8,
            widthConstant: 0,
            heightConstant: 0
        )
    }
}
