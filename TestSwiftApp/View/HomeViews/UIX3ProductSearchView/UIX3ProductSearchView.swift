import UIKit
import x3UI

@objc public protocol UIX3ProductSearchViewDelegate {
}
public class UIX3ProductSearchView: UIX3XibView {
    public struct Defaults {
        public static let Height = 0.0
    }
    
    @IBOutlet public weak var searchField: UIX3TextField? {
        didSet {
            self.searchField?.leftButtonType = .icon
            self.searchField?.leftButtonViewMode = .always
            self.searchField?.leftButtonImage = Config.Images.iconSearch?.withTintColor(Config.Colors.tint.withAlphaComponent(0.5))
            self.searchField?.leftButtonLeftOffset = 8
            self.searchField?.placeholder = "Search".localized
            self.searchField?.rightButtonType = .none
            self.searchField?.backgroundColor = Config.Colors.backgroundLight
            self.searchField?.layer.masksToBounds = true
            self.searchField?.layer.borderWidth = 1.5
            self.searchField?.layer.borderColor = Config.Colors.backgroundGray.cgColor
            self.searchField?.layer.cornerRadius = (self.frame.height / 2)
        }
    }
    @IBOutlet public weak var searchButton: UIButton? {
        didSet {
            self.searchButton?.layer.backgroundColor = Config.Colors.tint.cgColor
            self.searchButton?.tintColor = Config.Colors.backgroundLight
            self.searchButton?.clipsToBounds = true
            self.searchButton?.layer.masksToBounds = true
            self.searchButton?.layer.borderWidth = 1.0
            self.searchButton?.layer.borderColor = Config.Colors.tint.cgColor
            self.searchButton?.layer.cornerRadius = (17)
            self.searchButton?.setImage(Config.Images.iconCategory?.withRenderingModeTemplate, for: .normal)
        }
    }
    public override func setupView() {
        super.setupView()
    }
}
