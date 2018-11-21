import UIKit
import Kingfisher

extension UIImageView {

    func load(url: String) {
        self.kf.setImage(with: URL(string: url))
    }
}

extension UIView {

    func show() {
        self.isHidden = false
    }

    func hide() {
        self.isHidden = true
    }
}
