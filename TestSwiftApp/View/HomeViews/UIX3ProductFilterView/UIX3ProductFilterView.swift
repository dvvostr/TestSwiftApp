import UIKit
import x3UI

@objc public protocol UIX3ProductFilterViewDelegate {
    @objc optional func ProductFilterViewCancel(sender: Any?)
    @objc optional func ProductFilterViewDone(sender: Any?, values: Any?)
}

public class UIX3ProductFilterView: UIX3XibView {
    public struct Defaults {
        public static let Heigth = 340.0
    }
    
    @IBOutlet public weak var container: UIView?
    @IBOutlet public weak var labelCaption: UILabel?
    @IBOutlet public weak var buttonCancel: UIButton?
    @IBOutlet public weak var buttonDone: UIButton?

    @IBOutlet public weak var fieldValue1: UIX3ProductFilterFieldView?
    @IBOutlet public weak var fieldValue2: UIX3ProductFilterFieldView?
    @IBOutlet public weak var fieldValue3: UIX3ProductFilterFieldView?
    

    public var captionFont: UIFont? {
        didSet {
            self.labelCaption?.font = self.captionFont?.withSize(18)
        }
    }
    
    public var delegate: UIX3ProductFilterViewDelegate?
    
    public var values: NSDictionary? {
        get {
            return [:]
        }
    }
    public override func setupView() {
        super.setupView()
        self.backgroundColor = UIColor.clear
        self.container?.backgroundColor = UIColor.clear

        self.labelCaption?.text = "Filter options"
        self.labelCaption?.textColor = Config.Colors.blue
        initField(field: self.fieldValue1, type: .brand, caption: "Brand", value: "Samsung")
        initField(field: self.fieldValue2, type: .price, caption: "Price", value: "$300 - $500")
        initField(field: self.fieldValue3, type: .size, caption: "Size", value: "4.5 to 5.5 inches")

        self.buttonCancel?.addTarget(self, action: #selector(handleClick(sender: )), for: .touchUpInside)
        self.buttonDone?.addTarget(self, action: #selector(handleClick(sender: )), for: .touchUpInside)
    }
    private func initField(field: UIX3ProductFilterFieldView?, type: UIX3ProductFilterFieldViewType, caption: String, value: String) {
        guard let _obj = field else { return }
        _obj.valueLabel?.textColor = Config.Colors.blue
        _obj.type = type
        _obj.caption = caption
        _obj.value = value
        _obj.delegate = self
    }
    @objc private func handleClick(sender: UIButton?) {
        if sender == buttonCancel {
            self.delegate?.ProductFilterViewCancel?(sender: self)
        } else if sender == buttonDone {
            self.delegate?.ProductFilterViewDone?(sender: self, values: self.values)
        }
        self.closeController()
    }
    
    private func closeController() {
        guard let _vc = self.parentViewController as? UIX3ModalCardViewController else { return }
        _vc.hide()
    }
}

extension UIX3ProductFilterView: UIX3ProductFilterFieldViewDelegate {
    public func ProductFilterFieldViewClick(sender: Any?) {
        guard let _obj = sender as? UIX3ProductFilterFieldView else { return }
        ShowAlertView(message: "\(_obj.caption ?? "<?>") = \(_obj.value ?? "<?>")", buttons: [.ok])
    }
}
