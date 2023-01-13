import UIKit
import x3UI

@objc public protocol UIX3NavLocationViewDelegate {
    @objc optional func NavLocationViewClick(sender: Any?)
}
public class UIX3NavLocationView: UIX3XibView {
    @IBOutlet public weak var container: UIView?
    @IBOutlet public weak var label: UILabel?
    @IBOutlet public weak var imageLeft: UIImageView?
    @IBOutlet public weak var imageRight: UIImageView?
    @IBOutlet private weak var leftInputConstraint: NSLayoutConstraint?
    @IBOutlet private weak var rightInputConstraint: NSLayoutConstraint?

    public var delegate: UIX3NavLocationViewDelegate?
    
    public var offsetX: CGFloat = 0 {
        didSet {
            self.leftInputConstraint?.constant = offsetX
            self.rightInputConstraint?.constant = offsetX
        }
    }
    public override func setupView() {
        super.setupView()
        self.backgroundColor = UIColor.clear
        self.container?.backgroundColor = UIColor.clear
        self.label?.isUserInteractionEnabled = true
        self.label?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClick(sender:))))
    }
    @objc private func handleClick(sender: Any?) {
        self.delegate?.NavLocationViewClick?(sender: self)
    }
}
