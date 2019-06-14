import UIKit
import Kingfisher

class HomeViewCell: DatasourceCell {

    private lazy var card: CardView = {
        let view = CardView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4

        return view
    }()

    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.layer.borderWidth = 1
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill

        return view
    }()

    private lazy var label: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.textColor = .black
        view.textAlignment = .left

        return view
    }()

    override var datasource: Any? {
        didSet {
            guard let data = datasource as? Movie else { return }
            image.load(url: data.posterPath)
            label.text = data.title
        }
    }

    override func setupViews() {
        card.addSubview(image)
        card.addSubview(label)
        addSubview(card)

        image.anchor(
            safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            bottom: nil,
            right: rightAnchor,
            topConstant: 4,
            leftConstant: 4,
            bottomConstant: 4,
            rightConstant: 4,
            widthConstant: 0,
            heightConstant: 0
        )

        label.anchor(
            image.bottomAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            topConstant: 8,
            leftConstant: 8,
            bottomConstant: 8,
            rightConstant: 8,
            widthConstant: 0,
            heightConstant: 0
        )

        card.anchor(
            safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            topConstant: 4,
            leftConstant: 4,
            bottomConstant: 4,
            rightConstant: 4,
            widthConstant: 0,
            heightConstant: 0
        )
    }
}
