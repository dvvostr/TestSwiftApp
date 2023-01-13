import UIKit
import x3UI

@IBDesignable
public class UIX3ProductNavBarView: UIX3XibView {
    @IBOutlet public weak var containerView: UIView?
    @IBOutlet public weak var buttonExplorer: UIButton?
    @IBOutlet public weak var buttonCard: UIButton?
    @IBOutlet public weak var buttonFavotite: UIButton?
    @IBOutlet public weak var buttonUser: UIButton?
    @IBOutlet public weak var constraintLeading: NSLayoutConstraint?
    @IBOutlet public weak var constraintTraining: NSLayoutConstraint?
    
    public var horizontalOffset: CGFloat? {
        didSet{
            self.constraintLeading?.constant = self.horizontalOffset ?? 24
            self.constraintTraining?.constant = self.horizontalOffset ?? 24
        }
    }
    public override func setupView() {
        super.setupView()
        self.containerView?.clipsToBounds = true
        self.containerView?.layer.masksToBounds = true
        self.containerView?.backgroundColor = Config.Colors.blue
        self.horizontalOffset = 48.0
        self.buttonExplorer?.setTitle("Explorer".localized, for: .normal)
        self.buttonExplorer?.tintColor = Config.Colors.backgroundLight
        self.buttonExplorer?.titleLabel?.textColor = Config.Colors.backgroundLight
        self.buttonExplorer?.titleLabel?.font = Config.Fonts.MarkPro(size: 19, kind: .bold)
        self.buttonCard?.tintColor = Config.Colors.backgroundLight
        self.buttonFavotite?.tintColor = Config.Colors.backgroundLight
        self.buttonUser?.tintColor = Config.Colors.backgroundLight
    }
}
