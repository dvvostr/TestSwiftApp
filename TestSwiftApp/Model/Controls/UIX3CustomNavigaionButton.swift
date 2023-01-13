import Foundation
import UIKit
import x3UI

@objc public class UIX3CustomNavigaionButton: UIButton {
    public struct Defaults {
        public struct Color {
            public static var background: UIColor = UIColor.clear
        }
        public static var portraitSize: CGFloat = 36
        public static var landscapeSize: CGFloat = 28

    }
    private var _image: UIImage?
    public override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(didRotate), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    convenience public init(image: UIImage) {
        self.init(type: .custom)
        self._image = image
        self.setImage(image, for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.invalidate()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc private func didRotate() {
        self.invalidate()
    }
    private func invalidate() {
        self.tintColor = UIX3CustomControl.Defaults.Color.tint
        self.backgroundColor = UIX3CustomNavigaionButton.Defaults.Color.background
        let _isLandscape = [UIDeviceOrientation.landscapeLeft, UIDeviceOrientation.landscapeRight].contains(UIDevice.current.orientation),
            _size = (_isLandscape ? UIX3CustomNavigaionButton.Defaults.landscapeSize : UIX3CustomNavigaionButton.Defaults.portraitSize)
        self.frame = CGRect(x: 0, y: 0, width: _size, height: _size)
        self.layer.cornerRadius = _size / 2
    }
}
