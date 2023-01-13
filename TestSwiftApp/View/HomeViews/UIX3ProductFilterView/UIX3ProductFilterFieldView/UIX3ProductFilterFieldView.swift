import UIKit
import x3Core
import x3UI


@objc public protocol UIX3ProductFilterFieldViewDelegate {
    @objc optional func ProductFilterFieldViewClick(sender: Any?)
}

public enum UIX3ProductFilterFieldViewType {
    case inassigned, brand, price, size
}
public class UIX3ProductFilterFieldView: UIX3XibView {
    @IBOutlet public weak var container: UIView?
    @IBOutlet public weak var captionLabel: UILabel?
    @IBOutlet public weak var fieldView: UIView?
    @IBOutlet public weak var valueLabel: UILabel?
    @IBOutlet public weak var imageView: UIImageView?
    
    public var type: UIX3ProductFilterFieldViewType = .inassigned
    
    public var caption: String? {
        didSet {
            self.captionLabel?.text = self.caption ?? ""
        }
    }
    public var value: String? {
        didSet {
            self.valueLabel?.text = self.value ?? ""
        }
    }

    public var delegate: UIX3ProductFilterFieldViewDelegate?

    public override func setupView() {
        super.setupView()
        self.captionLabel?.textColor = Config.Colors.blue
        self.captionLabel?.font = Config.Fonts.MarkPro(size: 18)

        self.fieldView?.layer.masksToBounds = true
        self.fieldView?.layer.cornerRadius = 6
        self.fieldView?.layer.borderWidth = 1
        self.fieldView?.layer.borderColor = Config.Colors.gray.cgColor

        self.valueLabel?.textColor = Config.Colors.blue
        self.valueLabel?.font = Config.Fonts.MarkPro(size: 18)

        self.imageView?.tintColor = Config.Colors.gray
        self.imageView?.image = Config.Images.iconChevronDown?.withRenderingModeTemplate

        self.fieldView?.isUserInteractionEnabled = true
        self.fieldView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClick(sender: ))))
    }

    @objc private func handleClick(sender: Any?) {
        self.delegate?.ProductFilterFieldViewClick?(sender: self)
    }
}
