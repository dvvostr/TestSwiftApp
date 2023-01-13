import UIKit
import x3UI

@objc public protocol UIX3ProductDetailViewDelegate {
    @objc optional func ProductBestSales(readMoreSender: Any?)
    @objc optional func ProductBestSales(sender: Any?, itemClick: Any?)
    @objc optional func ProductBestSales(sender: Any?, itemChange: Any?)
}

@IBDesignable
public class UIX3ProductDetailView: UIX3XibView {
    public struct Defaults {
        public static let Height = 388.0
    }
    @IBOutlet public weak var containerView: UIView? {
        didSet {
            self.containerView?.setBorderRadius(22)
            self.containerView?.backgroundColor = Config.Colors.backgroundLight
        }
    }
    @IBOutlet public weak var captionLabel: UILabel? {
        didSet {
            self.captionLabel?.font = Config.Fonts.MarkPro(size: 24)
            self.captionLabel?.textColor = Config.Colors.blue
            self.captionLabel?.text = "".localized
        }
    }
    @IBOutlet public weak var favoriteButton: UIButton? {
        didSet {
            self.favoriteButton?.setTitle("", for: .normal)
            self.favoriteButton?.backgroundColor = Config.Colors.blue
            self.favoriteButton?.tintColor = Config.Colors.backgroundLight
            self.favoriteButton?.setImage(Config.Images.iconFavoriteOff?.withRenderingModeTemplate, for: UIControl.State.normal)
            self.favoriteButton?.setTitleColor(Config.Colors.backgroundLight, for: .normal)
            self.favoriteButton?.setBorderRadius(8)
            self.favoriteButton?.addTarget(self, action: #selector(handleFavoriteClick(sender: )), for: .touchUpInside)
        }
    }
    @IBOutlet public weak var cartButton: UIButton? {
        didSet {
            self.cartButton?.setTitle(" ", for: .normal)
            self.cartButton?.backgroundColor = Config.Colors.orange
            self.cartButton?.setTitleColor(Config.Colors.backgroundLight, for: .normal)
            self.cartButton?.setBorderRadius(8)
            self.cartButton?.addTarget(self, action: #selector(handleCartClick(sender: )), for: .touchUpInside)
            if let _title = self.cartButton?.titleLabel, let _view = _title.superview {
                _title.removeConstraints(_title.constraints)
                _title.anchor(nil, left: _view.leftAnchor, bottom: nil, right: _view.rightAnchor, topConstant: 0, leftConstant: 24, bottomConstant: 0, rightConstant: 24, widthConstant: 0, heightConstant: 0)
                _title.anchorCenterYToSuperview()
            }
            let _str = "<table style='width: 100%; font-family: MarkPro; font-size: 20px; font-width: 700; color: #FFFFFF;'><hr><td>\("Add to Cart".localized)</td><td style='text-align: right;'>\("?")</td></hr></table>".html2AttributedString
            self.cartButton?.setAttributedTitle(_str, for: .normal)
        }
    }
    @IBOutlet public weak var ratingView: UIStackView? {
        didSet {
            self.ratingView?.arrangedSubviews.forEach({ $0.removeFromSuperview() })
            self.ratingView?.alignment = .fill
            self.ratingView?.distribution = .fillEqually
            self.ratingView?.axis = .horizontal
            for i in [Int](1...5){
                let _image = UIImageView(image: Config.Images.iconStar?.withRenderingModeTemplate)
                _image.tintColor = Config.Colors.yellow
                _image.contentMode = .scaleAspectFit
                _image.tag = i
                _image.isUserInteractionEnabled = true
                _image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRatingItemClick(sender: ))))
                self.ratingView?.addArrangedSubview(_image)
            }
            self.setRating(Int(self.item?.rating ?? 0))
        }
    }
    @IBOutlet public weak var tabView: UIX3ProductDetailTabView? {
        didSet {
//            self.tabView?.segmentControl?.delegate = self
            self.tabView?.segmentControl?.items = ["Shop".localized, "Details".localized, "Features".localized]
            self.tabView?.productFeatures?.items = [
                UIX3ProductDetailFeatures.FeaturesItems(image: "imageCPU", caption: self.item?.CPU.localized),
                UIX3ProductDetailFeatures.FeaturesItems(image: "imagePhoto", caption: self.item?.camera.localized),
                UIX3ProductDetailFeatures.FeaturesItems(image: "imageRAM", caption: self.item?.ssd.localized),
                UIX3ProductDetailFeatures.FeaturesItems(image: "imageSDCard", caption: self.item?.sd.localized)
            ]
            self.tabView?.productDetailCapacityView?.capacityGroup?.strings = self.item?.capacity
            self.tabView?.productDetailCapacityView?.colorGroup?.strings = self.item?.color
        }
    }
    public var item: UIX3ProductDetailData? {
        didSet {
            self.captionLabel?.text = self.item?.title.localized ?? ""
            self.favoriteButton?.setImage(self.item?.isFavorites ?? false ? Config.Images.iconFavoriteOn?.withRenderingModeTemplate : Config.Images.iconFavoriteOff?.withRenderingModeTemplate, for: UIControl.State.normal)
            let _str = "<table style='width: 100%; font-family: MarkPro; font-size: 20px; font-width: 700; color: #FFFFFF;'><hr><td>\("Add to Cart".localized)</td><td style='text-align: right;'>\(self.formatCurrency(self.item?.price))</td></hr></table>".html2AttributedString
            self.cartButton?.setAttributedTitle(_str, for: .normal)
            self.self.setRating(Int(self.item?.rating ?? 0))
            self.tabView?.productFeatures?.items = [
                UIX3ProductDetailFeatures.FeaturesItems(image: "imageCPU", caption: self.item?.CPU.localized),
                UIX3ProductDetailFeatures.FeaturesItems(image: "imagePhoto", caption: self.item?.camera.localized),
                UIX3ProductDetailFeatures.FeaturesItems(image: "imageRAM", caption: self.item?.ssd.localized),
                UIX3ProductDetailFeatures.FeaturesItems(image: "imageSDCard", caption: self.item?.sd.localized)
            ]
            self.tabView?.productDetailCapacityView?.capacityGroup?.strings = self.item?.capacity
            self.tabView?.productDetailCapacityView?.colorGroup?.strings = self.item?.color
        }
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
    private func setRating(_ value: Int) {
        self.ratingView?.arrangedSubviews.forEach({ _view in
            if let _image = _view as? UIImageView {
                _image.tintColor = _image.tag <= value ? Config.Colors.yellow : Config.Colors.gray
            }
        })
    }
    @objc private func handleFavoriteClick(sender: Any?) {
        self.item?.isFavorites = !(self.item?.isFavorites ?? true)
        self.favoriteButton?.setImage(self.item?.isFavorites ?? false ? Config.Images.iconFavoriteOn?.withRenderingModeTemplate : Config.Images.iconFavoriteOff?.withRenderingModeTemplate, for: UIControl.State.normal)
    }
    @objc private func handleCartClick(sender: Any?) {
    }
    @objc private func handleRatingItemClick(sender: Any?) {
        guard let _index = (sender as? UITapGestureRecognizer)?.view?.tag else { return }
        self.setRating(_index)
    }
}
extension UIX3ProductDetailView: ControlEventDelegate {
    public func controlEvent(_ sender: Any?, event: Any?) {
        print("controlEvent")
    }
}
