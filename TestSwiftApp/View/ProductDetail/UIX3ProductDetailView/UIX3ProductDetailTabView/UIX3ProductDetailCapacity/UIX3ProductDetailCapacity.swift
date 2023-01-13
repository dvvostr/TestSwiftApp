import UIKit
import x3UI

@objc public protocol UIX3ProductDetailCapacityDelegate {
    @objc optional func ProductDetailCapacity(readMoreSender: Any?)
    @objc optional func ProductDetailCapacity(sender: Any?, itemClick: Any?)
    @objc optional func ProductDetailCapacity(sender: Any?, itemChange: Any?)
}

@IBDesignable
public class UIX3ProductDetailCapacity: UIX3XibView {
    @IBOutlet public weak var captionLabel: UILabel? {
        didSet {
            self.captionLabel?.textColor = Config.Colors.blue
            self.captionLabel?.font = Config.Fonts.MarkPro(size: 16)
            self.captionLabel?.text = "Select color and capacity".localized
        }
    }
    @IBOutlet public weak var colorGroup: UIX3ProductColorGroupView?
    @IBOutlet public weak var capacityGroup: UIX3ProductCapacityGroupView?
}
