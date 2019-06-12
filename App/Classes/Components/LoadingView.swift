import UIKit

open class LoadingView: UIView {

    private lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.hidesWhenStopped = true

        return view
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.initView()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func showAnimation() {
        indicator.startAnimating()
    }

    open func hideAnimation() {
        indicator.stopAnimating()
        self.removeFromSuperview()
    }

    private func initView() {
        addSubview(indicator)
        indicator.anchorCenterSuperview()
    }
}
