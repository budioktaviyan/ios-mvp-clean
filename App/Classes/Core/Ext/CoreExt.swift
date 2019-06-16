import UIKit
import Kingfisher

extension Dictionary {

    func nullKeyRemoval() -> Dictionary {
        var dict: [Key: Value] = self

        let keysToRemove: [Key] = dict.keys.filter {
            guard let value: String = dict[$0] as? String else { return false }
            return value == ""
        }

        let _ = keysToRemove.compactMap { key in
            dict.removeValue(forKey: key)
        }
        print("dictionary is: \(dict)")

        return dict
    }
}

extension UIImageView {

    func load(url: String) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: url))
    }

    func loadAndResize(url: String, view: DatasourceCell) {
        self.kf.setImage(
            with: URL(string: url),
            placeholder: nil,
            options: nil,
            progressBlock: nil,
            completionHandler: { result in
                switch result {
                case .success(let value):
                    let image = value.image
                    self.image = UIImage.resize(image: image, targetSize: CGSize(width: view.contentView.frame.width, height: 256))
                case .failure(let error):
                    print(error.localizedDescription)
                }
        })
    }
}

extension UIView {

    func show() {
        self.isHidden = false
    }

    func hide() {
        self.isHidden = true
    }

    func anchor(
        _ top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leftConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        rightConstant: CGFloat = 0,
        widthConstant: CGFloat = 0,
        heightConstant: CGFloat = 0) {
        _ = anchorWithReturnAnchors(
            top, left: left,
            bottom: bottom,
            right: right,
            topConstant: topConstant,
            leftConstant: leftConstant,
            bottomConstant: bottomConstant,
            rightConstant: rightConstant,
            widthConstant: widthConstant,
            heightConstant: heightConstant
        )
    }

    func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }

    private func anchorWithReturnAnchors(
        _ top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leftConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        rightConstant: CGFloat = 0,
        widthConstant: CGFloat = 0,
        heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()
        if let top = top { anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant)) }
        if let left = left { anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant)) }
        if let bottom = bottom { anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant)) }
        if let right = right { anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant)) }
        if widthConstant > 0 { anchors.append(widthAnchor.constraint(equalToConstant: widthConstant)) }
        if heightConstant > 0 { anchors.append(heightAnchor.constraint(equalToConstant: heightConstant)) }
        anchors.forEach({$0.isActive = true})

        return anchors
    }

    private func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let anchor = superview?.centerXAnchor else { return }
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    private func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let anchor = superview?.centerYAnchor else { return }
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
}

extension UIImage {

    static func resize(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        let widthRatio = targetSize.width / image.size.width
        let heightRatio = targetSize.height / image.size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize = CGSize(width: 0, height: 0)
        switch newSize {
        case _ where widthRatio > heightRatio:
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        default:
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
