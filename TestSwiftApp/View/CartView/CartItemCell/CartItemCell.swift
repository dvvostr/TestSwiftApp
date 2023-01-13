import UIKit
import x3Core
import x3UI
import Nuke

@objc public protocol UIX3CustomCollectionCellDelegate {
    @objc optional func CartItemCellEvent(cellChange: Any?) -> (Void)
    @objc optional func CartItemCellEvent(cellDrop: Any?) -> (Void)
}
class CartItemCell: UIX3CustomCollectionCell {
    public struct Defaults {
        public static let Height = 132.0
    }
    @IBOutlet public weak var imageView: UIImageView? {
        didSet{}
    }
    @IBOutlet public weak var labelCaption: UIX3VerticalTopAlignLabel? {
        didSet{}
    }
    @IBOutlet public weak var labelPrice: UILabel? {
        didSet{
            self.labelPrice?.font = Config.Fonts.MarkPro(size: 20)
            self.labelPrice?.textColor = Config.Colors.orange
        }
    }
    @IBOutlet public weak var viewTools: UIView? {
        didSet {
            self.viewTools?.setBorderRadius(12)
            self.viewTools?.backgroundColor = Config.Colors.darkGray
        }
    }
    @IBOutlet public weak var buttonPlus: UIButton? {
        didSet {
            self.buttonPlus?.tintColor = Config.Colors.backgroundLight
            self.buttonPlus?.addTarget(self, action: #selector(handleToolsButtonClick(sender: )), for: .touchUpInside)
        }
    }
    @IBOutlet public weak var buttonMinus: UIButton? {
        didSet {
            self.buttonMinus?.tintColor = Config.Colors.backgroundLight
            self.buttonMinus?.addTarget(self, action: #selector(handleToolsButtonClick(sender: )), for: .touchUpInside)
        }
    }
    @IBOutlet public weak var buttonTrash: UIButton? {
        didSet {
            self.buttonTrash?.setImage(Config.Images.iconTrashBin?.withRenderingModeTemplate, for: .normal)
            self.buttonTrash?.tintColor = Config.Colors.backgroundLight
            self.buttonTrash?.addTarget(self, action: #selector(handleToolsButtonClick(sender: )), for: .touchUpInside)
        }
    }
    @IBOutlet public weak var labelQty: UILabel? {
        didSet {
            self.labelQty?.textColor = Config.Colors.backgroundLight
            self.labelQty?.font = Config.Fonts.MarkPro(size: 20)
        }
    }
    public var item: UIX3CartDataItem? {
        didSet {
            
            let _attrString: NSMutableAttributedString = NSMutableAttributedString(string: item?.title ?? "", attributes: [
                NSAttributedString.Key.font : Config.Fonts.MarkPro(size: 20) ?? UIFont.systemFont(ofSize: 20),
                NSAttributedString.Key.foregroundColor : Config.Colors.backgroundLight
            ])
            self.labelCaption?.attributedText = _attrString
            self.labelPrice?.text = formatCurrency(self.item?.price)
            self.labelQty?.text = String(self.item?.qty ?? 1)
            var _options = ImageLoadingOptions(
                placeholder: nil,
                transition: .fadeIn(duration: 0.25),
                failureImage: nil
            )
            _options.pipeline = Nuke.ImagePipeline.shared
            let _URL = URL(string: self.item?.images ?? "NONE")!
            if let _picture = self.imageView {
                DispatchQueue.main.async {
                    Nuke.loadImage(with: _URL, options: _options, into: _picture)
                }
            }
        }
    }
    public var delegate: UIX3CustomCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setupView() {
        super.setupView()
    }
    private func formatCurrency(_ value: Double?) -> String {
        guard let _value = value else { return "" }
        let _formatter = NumberFormatter()
        _formatter.locale = Locale.current
        _formatter.numberStyle = .currency
        _formatter.maximumFractionDigits = 2
        if let _val = _formatter.string(from: _value as NSNumber) {
            return _val
        } else {
            return ""
        }
    }
    @objc private func handleToolsButtonClick(sender: Any?) {
        guard let _item = self.item, let _sender = sender as? UIButton else { return }
        if _sender == buttonPlus {
            _item.qty += 1
            self.delegate?.CartItemCellEvent?(cellChange: self)
        } else if _sender == buttonMinus && _item.qty > 0 {
            _item.qty -= 1
            self.delegate?.CartItemCellEvent?(cellChange: self)
        } else if _sender == buttonTrash {
            self.delegate?.CartItemCellEvent?(cellDrop: self)
        }
    }
}
