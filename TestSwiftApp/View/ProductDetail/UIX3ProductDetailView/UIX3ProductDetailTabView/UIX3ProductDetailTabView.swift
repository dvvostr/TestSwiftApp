import UIKit
import x3UI

@objc public protocol UIX3ProductDetailTabViewDelegate {
    @objc optional func ProductBestSales(readMoreSender: Any?)
    @objc optional func ProductBestSales(sender: Any?, itemClick: Any?)
    @objc optional func ProductBestSales(sender: Any?, itemChange: Any?)
}

@IBDesignable
public class UIX3ProductDetailTabView: UIX3XibView {
    @IBOutlet public weak var segmentControl: UITabSegmentControl? {
        didSet {
            self.segmentControl?.font = Config.Fonts.MarkPro(size: 18)
            self.segmentControl?.tintColor = Config.Colors.gray
            self.segmentControl?.selectedSegmentTintColor = Config.Colors.blue
            self.segmentControl?.addTarget(self, action: #selector(handleSegmentValueChanged(sender:)), for: UIControl.Event.valueChanged)
        }
    }
    @IBOutlet public weak var productFeatures: UIX3ProductDetailFeatures? {
        didSet {

        }
    }
    @IBOutlet public weak var productDetailCapacityView: UIX3ProductDetailCapacity?
    
    public override func setupView() {
        super.setupView()
    }
    @objc private func handleSegmentValueChanged(sender: Any?) {
        self.segmentControl?.underlinePosition()
    }
}
