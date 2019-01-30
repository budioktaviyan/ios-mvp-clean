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
