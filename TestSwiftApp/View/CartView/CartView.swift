import UIKit
import x3Core
import x3UI

@objc public protocol CartViewDelegate {
    @objc optional func CartView(readMoreSender: Any?)
    @objc optional func CartView(checkoutSender: Any?)
}

@IBDesignable
public class CartView: UIX3XibView {
    @IBOutlet public weak var collectionView: UIX3CollectionView? {
        didSet {
            self.collectionView?.collectionViewDelegate = self
        }
    }
    @IBOutlet public weak var totalView: UIView? {
        didSet {
            self.totalView?.addBorders(edges: [.top, .bottom], color: Config.Colors.backgroundLight.withAlphaComponent(0.2))
        }
    }
    @IBOutlet public weak var totalCaption: UILabel? {
        didSet {
            self.totalCaption?.font = Config.Fonts.MarkPro(size: 16)
            self.totalCaption?.textColor = Config.Colors.backgroundLight
            self.totalCaption?.text = "Total".localized
        }
    }
    @IBOutlet public weak var totalValue: UILabel? {
        didSet {
            self.totalValue?.font = Config.Fonts.MarkPro(size: 16)
            self.totalValue?.textColor = Config.Colors.backgroundLight
            self.totalValue?.text = "".localized
        }
    }
    @IBOutlet public weak var deliveryCaption: UILabel? {
        didSet {
            self.deliveryCaption?.font = Config.Fonts.MarkPro(size: 16)
            self.deliveryCaption?.textColor = Config.Colors.backgroundLight
            self.deliveryCaption?.text = "Delivery".localized
        }
    }
    @IBOutlet public weak var DeliveryValue: UILabel? {
        didSet {
            self.DeliveryValue?.font = Config.Fonts.MarkPro(size: 16)
            self.DeliveryValue?.textColor = Config.Colors.backgroundLight
            self.DeliveryValue?.text = "".localized
        }
    }

    @IBOutlet public weak var checkoutButton: UIButton? {
        didSet {
            self.checkoutButton?.setTitle("Checkout", for: .normal)
            self.checkoutButton?.backgroundColor = Config.Colors.orange
            self.checkoutButton?.setTitleColor(Config.Colors.backgroundLight, for: .normal)
            self.checkoutButton?.setBorderRadius(8)
            self.checkoutButton?.addTarget(self, action: #selector(handleCheckoutClick(sender: )), for: .touchUpInside)
            if let _title = self.checkoutButton?.titleLabel, let _view = _title.superview {
                _title.textAlignment = .center
                _title.removeConstraints(_title.constraints)
                _title.anchor(nil, left: _view.leftAnchor, bottom: nil, right: _view.rightAnchor, topConstant: 0, leftConstant: 24, bottomConstant: 0, rightConstant: 24, widthConstant: 0, heightConstant: 0)
                _title.anchorCenterYToSuperview()
            }
        }
    }
    public var item: UIX3CartListData? {
        didSet {
            self.invalidate()
        }
    }
    public override func setupView() {
        super.setupView()
        self.backgroundColor = Config.Colors.blue
    }
    public func invalidate() {
        self.collectionView?.reloadData()
        self.totalValue?.text = self.item?.calcTotal().asCurrencyString ?? ""
        self.DeliveryValue?.text = self.item?.delivery ?? ""
    }
    
    @objc private func handleCheckoutClick(sender: Any?) {
        
    }
}
extension CartView: UIX3CollectionViewDelegate {
    public func collectionView(setupFor collectionView: UIX3CollectionView) {
        collectionView.registerNib(CartItemCell.self)
    }
    public func collectionView(numberOfSectionsOf collectionView: UIX3CollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UIX3CollectionView, numberOfRowsInSection section: Int) -> Int {
        let _val = self.item?.basket.count ?? 0
        return _val
    }
    public func collectionView(_ collectionView: UIX3CollectionView, rowForIndexPath indexPath: IndexPath) -> UIX3CustomCollectionCell.Type {
        return CartItemCell.self
    }
    public func collectionView(_ collectionView: UIX3CollectionView, layout: UICollectionViewLayout, sizeForCollectionCellAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView?.frame.width ?? 0), height: CartItemCell.Defaults.Height)
    }
    public func collectionView(_ collectionView: UIX3CollectionView, indexPath: IndexPath, collectionCellDidLoad cell: UICollectionViewCell?) {
        guard let _cell = cell as? CartItemCell else { return }
        if let _item = self.item?.basket[indexPath.row] {
            _cell.item = _item
            _cell.delegate = self
        }
    }
    public func collectionView(_ collectionView: UIX3CollectionView, willDisplay cell: UICollectionViewCell, forRowAt indexPath: IndexPath) {
        
    }
}
extension CartView: UIX3CustomCollectionCellDelegate {
    public func CartItemCellEvent(cellChange: Any?) {
        self.invalidate()
    }
    public func CartItemCellEvent(cellDrop: Any?) {
        guard let _item = (cellDrop as? CartItemCell)?.item else { return }
        self.item?.basket.removeAll(where: { $0.id == _item.id})
        self.invalidate()
    }
}
