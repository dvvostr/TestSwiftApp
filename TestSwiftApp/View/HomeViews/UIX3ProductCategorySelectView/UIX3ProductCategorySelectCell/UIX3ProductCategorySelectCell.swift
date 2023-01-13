import UIKit
import x3Core
import x3UI

class UIX3ProductCategorySelectCell: UIX3CustomCollectionCell {
    @IBOutlet public weak var imageView: UIImageView? {
        didSet {
            self.imageView?.backgroundColor = Config.Colors.backgroundLight
        }
    }
    @IBOutlet public weak var captionLabel: UILabel? {
        didSet {
            self.imageSize = 64.0
            self.captionLabel?.font = Config.Fonts.MarkPro(size: 12)
        }
    }
    @IBOutlet private weak var imageWidthConstraint: NSLayoutConstraint? {
        didSet {
            self.imageWidthConstraint?.constant = imageSize
        }
    }
    
    public var onClick: ObjectEvent?
    
    
    public var imageSize: CGFloat = 66.0 {
        didSet {
            self.imageView?.layer.masksToBounds = true
            self.imageView?.clipsToBounds = true
            self.imageView?.layer.cornerRadius = (self.imageSize / 2)
            self.imageWidthConstraint?.constant = imageSize
        }
    }
    public var item: UIX3ProductCategoryItem? {
        didSet {
            self.captionLabel?.text = item?.caption ?? ""
            self.imageView?.image = UIImage(named: item?.imageName ?? "")?
                .withInset(insets: UIEdgeInsets(top: imageSize / 4, left: imageSize / 4, bottom: imageSize / 4, right: imageSize / 4))
                .withRenderingModeTemplate
            self.captionLabel?.textColor = (self.item?.isSelected ?? false) ? Config.Colors.tint : Config.Colors.blue
            self.imageView?.tintColor = (self.item?.isSelected ?? false) ? Config.Colors.backgroundLight : Config.Colors.blue.withAlphaComponent(0.3)
            self.imageView?.layer.cornerRadius = (self.imageSize / 2)
            self.imageView?.layer.backgroundColor = ((self.item?.isSelected ?? false) ? Config.Colors.tint : Config.Colors.backgroundLight).cgColor
        }
    }
    override func setupView() {
        self.contentView.isUserInteractionEnabled = true
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClick(sender: ))))
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @objc private func handleClick(sender: Any?) {
        self.onClick?(self)
    }

}
