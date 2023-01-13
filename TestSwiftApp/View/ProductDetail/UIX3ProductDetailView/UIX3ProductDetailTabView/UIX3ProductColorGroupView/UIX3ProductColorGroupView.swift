import UIKit
import x3UI

@IBDesignable
public class UIX3ProductColorGroupView: UIX3XibView {
    @IBOutlet public weak var colorStackView: UIStackView? {
        didSet {
            self.colorStackView?.axis = .horizontal
            self.colorStackView?.distribution = .fillEqually
            self.colorStackView?.alignment = .fill
            self.colorStackView?.translatesAutoresizingMaskIntoConstraints = false
            self.items = []
        }
    }
    public var strings: [String]? {
        didSet {
            self.colorStackView?.arrangedSubviews.forEach({ $0.removeFromSuperview() })
            for (_index, _item) in (strings ?? []).enumerated() {
                self.colorStackView?.addArrangedSubview(createColorView(index: _index, item: UIX3ProductColorItem(caption: "", colorName: _item, isSelected: false)))
            }
        }
    }
    public var items: [UIX3ProductColorItem]? {
        didSet{
            self.colorStackView?.arrangedSubviews.forEach({ $0.removeFromSuperview() })
            for (_index, _item) in (items ?? []).enumerated() {
                self.colorStackView?.addArrangedSubview(createColorView(index: _index, item: _item))
            }
        }
    }
    private func createColorView(index: Int, item: UIX3ProductColorItem) -> UIView {
        let _view = UIView()
        let _image = UIDataImageView(frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0))
        _view.addSubview(_image)
        _image.setBorderRadius(20)
        _image.anchorCenterSuperview()
        let _ = _image.anchorSize(widthConstant: 40, heightConstant: 40)
        _image.backgroundColor = UIColor.fromHex(hexString: item.colorName)
        _image.tintColor = Config.Colors.backgroundLight
        _image.image = item.isSelected ? Config.Images.iconChecked?.withInset(insets: 10).withRenderingModeTemplate : nil
        _image.data = item
        _image.isUserInteractionEnabled = true
        _image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleColorClick(sender: ))))
        _image.tag = index
        return _view
    }
    @objc private func handleColorClick(sender: Any?) {
        guard let _view = (sender as? UIGestureRecognizer)?.view as? UIDataImageView else { return }
        self.colorStackView?.arrangedSubviews.forEach({ _obj in
            if let _image = _obj.subviews.first as? UIDataImageView {
                (_image.data as? UIX3ProductColorItem)?.isSelected = (_image.tag == _view.tag)
                _image.image = (_image.tag == _view.tag) ? Config.Images.iconChecked?.withInset(insets: 10).withRenderingModeTemplate : nil
            }
        })
    }
}
