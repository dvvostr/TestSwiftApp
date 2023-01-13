import UIKit
import x3Core
import x3UI
import Nuke

class UIX3ProductHotSalesCell: UIX3CustomCollectionCell {
    @IBOutlet public weak var containerView: UIView? {
        didSet {
            self.containerView?.clipsToBounds = true
            self.containerView?.layer.masksToBounds = true
            self.containerView?.layer.cornerRadius = 8.0
        }
    }
    @IBOutlet public weak var imageView: UIImageView? {
        didSet {
            self.imageView?.backgroundColor = Config.Colors.backgroundLight
        }
    }
    @IBOutlet public weak var newView: UIView? {
        didSet {
            self.newView?.backgroundColor = Config.Colors.orange
            self.newView?.clipsToBounds = true
            self.newView?.layer.masksToBounds = true
            self.newView?.layer.cornerRadius = 14
        }
    }
    @IBOutlet public weak var newLabel: UILabel? {
        didSet {
            self.newLabel?.textColor = Config.Colors.backgroundLight
            self.newLabel?.text = "New".localized
            self.newLabel?.font = Config.Fonts.MarkPro(size: 12.0)
        }
    }
    @IBOutlet public weak var markView: UIView? {
        didSet {
//            self.markView?.backgroundColor = UIColor.black.withAlphaComponent(0.35)
            self.markView?.layer.shadowColor = UIColor.black.cgColor
            self.markView?.layer.shadowOpacity = 0.5
            self.markView?.layer.shadowOffset = .zero
            self.markView?.layer.shadowRadius = 10
            self.markView?.layer.shadowPath = UIBezierPath(rect: self.markView?.bounds ?? CGRect.zero).cgPath
            self.markView?.layer.shouldRasterize = true
            self.markView?.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    @IBOutlet public weak var captionLabel: UILabel? {
        didSet {
            self.captionLabel?.font = Config.Fonts.MarkPro(size: 22)
            self.captionLabel?.textColor = Config.Colors.backgroundLight
        }
    }
    @IBOutlet public weak var descriptionLabel: UILabel? {
        didSet {
            self.descriptionLabel?.font = Config.Fonts.MarkPro(size: 12)
            self.descriptionLabel?.textColor = Config.Colors.backgroundLight
        }
    }
    @IBOutlet public weak var buyButton: UIButton? {
        didSet {
            self.buyButton?.tintColor = Config.Colors.blue
            self.buyButton?.clipsToBounds = true
            self.buyButton?.layer.masksToBounds = true
            self.buyButton?.layer.borderWidth = 1.0
            self.buyButton?.layer.borderColor = Config.Colors.backgroundLight.cgColor
            self.buyButton?.layer.cornerRadius = (5)
            self.buyButton?.setTitle("Buy now!".localized, for: .normal)
//            self.buyButton?.font = Config.Fonts.MarkPro(size: 11)
            self.buyButton?.addTarget(self, action: #selector(handleButtonClick(sender: )), for: .touchUpInside)
        }
    }
    public var onButtonClick: ObjectEvent?
    
    public var item: UIX3ProductHomeStoreItem? {
        didSet{
            self.buyButton?.isHidden = (!(item?.isBuy ?? false))
            self.newView?.isHidden = (!(item?.isNew ?? false))
            self.captionLabel?.text = item?.title
            self.descriptionLabel?.text = item?.subtitle
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
        }
    }
    override func setupView() {
        super.setupView()
    }
    @objc private func handleButtonClick(sender: Any?) {
        self.onButtonClick?(self)
    }

}
