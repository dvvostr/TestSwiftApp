import UIKit
import x3UI

public class UIX3ProductDetailFeatures: UIX3XibView {
    public struct FeaturesItems {
        var image: String?
        var caption: String?
    }
    
    @IBOutlet public weak var featuresList: UIStackView? {
        didSet {
            self.featuresList?.axis = .horizontal
            self.featuresList?.distribution = .fillEqually
            self.featuresList?.alignment = .fill
            self.featuresList?.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    public var items: [FeaturesItems] = [] {
        didSet {
            self.featuresList?.arrangedSubviews.forEach({ $0.removeFromSuperview() })
            self.items.forEach({ _item in
                let _view = UIView()
                let _image = UIImageView(image: UIImage(named: _item.image ?? "")?.withRenderingModeTemplate)
                _view.addSubview(_image)
                _image.tintColor = Config.Colors.gray
                _image.contentMode = .scaleAspectFit
                let _caption = UILabel()
                _caption.font = Config.Fonts.MarkPro(size: 12)
                _caption.textColor = Config.Colors.gray
                _caption.text = _item.caption
                _caption.textAlignment = .center
                _view.addSubview(_caption)
                _caption.anchor(nil, left: _view.leftAnchor, bottom: _view.bottomAnchor, right: _view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 14.0)
                _image.anchorCenterXToSuperview(constant: 0)
                _image.anchorCenterYToSuperview(constant: -10)
                _image.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 28, heightConstant: 28)
                self.featuresList?.addArrangedSubview(_view)
            })
        }
    }
    public override func setupView() {
        super.setupView()
    }
}

