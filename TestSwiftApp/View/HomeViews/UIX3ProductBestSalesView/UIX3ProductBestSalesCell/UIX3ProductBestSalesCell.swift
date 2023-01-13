import UIKit
import x3Core
import x3UI
import Nuke


class UIX3ProductBestSalesCell: UIX3CustomCollectionCell {
    @IBOutlet public weak var containerView: UIView? {
        didSet {
            self.containerView?.clipsToBounds = true
            self.containerView?.layer.masksToBounds = true
            self.containerView?.layer.cornerRadius = 8.0
            self.containerView?.backgroundColor = Config.Colors.backgroundLight
            self.containerView?.isUserInteractionEnabled = true
            self.containerView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleItemClick(sender: ))))
        }
    }
    @IBOutlet public weak var imageView: UIImageView? {
        didSet {
            self.imageView?.backgroundColor = Config.Colors.backgroundLight
        }
    }
    @IBOutlet public weak var favoriteImageView: UIImageView? {
        didSet {
            self.favoriteImageView?.tintColor = Config.Colors.orange
            self.favoriteImageView?.clipsToBounds = true
            self.favoriteImageView?.layer.masksToBounds = true
            self.favoriteImageView?.layer.cornerRadius = 13.0
            self.favoriteImageView?.backgroundColor = Config.Colors.backgroundLight
            self.favoriteImageView?.addShadow(offset: CGSize(width: 0, height: 0), color: .black, opacity: 0.35, radius: 5.0)
            self.favoriteImageView?.isUserInteractionEnabled = true
            self.favoriteImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFavoriteClick(sender: ))))
        }
    }
    @IBOutlet public weak var labelTitle: UILabel? {
        didSet {
            self.labelTitle?.font = Config.Fonts.MarkPro(size: 13)
            self.labelTitle?.textColor = Config.Colors.blue
        }
    }
    @IBOutlet public weak var labelPrice: UILabel? {
        didSet {
            self.labelTitle?.font = Config.Fonts.MarkPro(size: 13)
            self.labelTitle?.textColor = Config.Colors.gray
        }
    }
    @IBOutlet public weak var labelDiscount: UILabel? {
        didSet {
            self.labelDiscount?.font = Config.Fonts.MarkPro(size: 16)
            self.labelDiscount?.textColor = Config.Colors.blue
        }
    }
    public var onItemClick: ObjectEvent?
    public var onFavoriteClick: ObjectEvent?
    
    public var item: UIX3ProductBestSalesItem? {
        didSet{
            let _attrString: NSMutableAttributedString = NSMutableAttributedString(string: formatCurrency(self.item?.discount), attributes: [
                NSAttributedString.Key.font : Config.Fonts.MarkPro(size: 13) ?? UIFont.systemFont(ofSize: 13),
                NSAttributedString.Key.foregroundColor : Config.Colors.gray
            ])
            _attrString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: _attrString.length))

            self.labelPrice?.attributedText = _attrString
            if let _val = item?.price {
                self.labelDiscount?.text = formatCurrency(_val)
            } else {
                self.labelDiscount?.text = ""
            }
            self.labelTitle?.text = self.item?.title ?? ""
            var _options = ImageLoadingOptions(
                placeholder: nil,
                transition: .fadeIn(duration: 0.25),
                failureImage: nil
            )
            _options.pipeline = Nuke.ImagePipeline.shared
            let _URL = URL(string: self.item?.image ?? "NONE")!
            if let _picture = self.imageView {
                DispatchQueue.main.async {
                    Nuke.loadImage(with: _URL, options: _options, into: _picture)
                }
            }
            self.favoriteImageView?.image = (self.item?.isFavorite ?? false) ?
                Config.Images.iconFavoriteOn?.withInset(insets: 6.0).withRenderingModeTemplate :
                Config.Images.iconFavoriteOff?.withInset(insets: 6.0).withRenderingModeTemplate
        }
    }
    override func setupView() {
        super.setupView()
    }
    private func formatCurrency(_ value: Double?) -> String {
        guard let _value = value else { return "" }
        let _formatter = NumberFormatter()
        _formatter.locale = Locale.current
        _formatter.numberStyle = .currency
        _formatter.maximumFractionDigits = 0
        if let _val = _formatter.string(from: _value as NSNumber) {
            return _val
        } else {
            return ""
        }
    }
    @objc private func handleItemClick(sender: Any?) {
        self.onItemClick?(self)
    }
    @objc private func handleFavoriteClick(sender: Any?) {
        self.onFavoriteClick?(self)
    }
}
