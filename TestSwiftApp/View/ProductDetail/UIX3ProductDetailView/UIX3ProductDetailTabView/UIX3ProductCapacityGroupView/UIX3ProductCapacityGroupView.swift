import UIKit
import x3UI

@IBDesignable
public class UIX3ProductCapacityGroupView: UIX3XibView {
    @IBOutlet public weak var capacityStackView: UIStackView? {
        didSet {
            self.capacityStackView?.axis = .horizontal
            self.capacityStackView?.distribution = .fillEqually
            self.capacityStackView?.alignment = .fill
            self.capacityStackView?.translatesAutoresizingMaskIntoConstraints = false
            self.items = [
                UIX3ProductCapacityItem(caption: "128 GB", isSelected: true),
                UIX3ProductCapacityItem(caption: "256 gb", isSelected: false)
            ]
        }
    }
    public var strings: [String]? {
        didSet {
            self.capacityStackView?.arrangedSubviews.forEach({ $0.removeFromSuperview() })
            for (_index, _item) in (strings ?? []).enumerated() {
                self.capacityStackView?.addArrangedSubview(createCapacityView(index: _index, item: UIX3ProductCapacityItem(caption: "\(_item)GB", isSelected: false)))
            }
        }
    }
    public var items: [UIX3ProductCapacityItem]? {
        didSet{
            self.capacityStackView?.arrangedSubviews.forEach({ $0.removeFromSuperview() })
            for (_index, _item) in (items ?? []).enumerated() {
                self.capacityStackView?.addArrangedSubview(createCapacityView(index: _index, item: _item))
            }
        }
    }
    private func createCapacityView(index: Int, item: UIX3ProductCapacityItem) -> UIView {
        let _view = UIDataView()
        let _label = UILabel(frame: .zero)
        _view.addSubview(_label)
        _label.setBorderRadius(10)
        _label.anchorCenterSuperview()
        let _ = _label.anchorSize(widthConstant: 72, heightConstant: 32)
        _label.backgroundColor = item.isSelected ? Config.Colors.orange : .clear
        _label.textColor = item.isSelected ? Config.Colors.backgroundLight : Config.Colors.gray
        _label.text = item.caption.localized
        _label.font = Config.Fonts.MarkPro(size: 13)
        _label.textAlignment = .center
        _view.data = item
        _label.isUserInteractionEnabled = true
        _label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCapacityClick(sender: ))))
        _view.tag = index
        return _view
    }
    @objc private func handleCapacityClick(sender: Any?) {
        guard let _view = (sender as? UIGestureRecognizer)?.view?.superview as? UIDataView else { return }
        self.capacityStackView?.arrangedSubviews.forEach({ _obj in
            if let _obj = _obj as? UIDataView, let _label = _obj.subviews.first as? UILabel {
                (_obj.data as? UIX3ProductCapacityItem)?.isSelected = (_obj.tag == _view.tag)
                _label.backgroundColor = (_obj.data as? UIX3ProductCapacityItem)?.isSelected ?? false ? Config.Colors.orange : .clear
                _label.textColor = (_obj.data as? UIX3ProductCapacityItem)?.isSelected ?? false ? Config.Colors.backgroundLight : Config.Colors.gray
            }
        })
    }
}
