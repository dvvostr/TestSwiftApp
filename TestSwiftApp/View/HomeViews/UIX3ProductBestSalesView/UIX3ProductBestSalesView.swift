import UIKit
import x3UI

@objc public protocol UIX3ProductBestSalesViewDelegate {
    @objc optional func ProductBestSales(readMoreSender: Any?)
    @objc optional func ProductBestSales(sender: Any?, itemClick: Any?)
    @objc optional func ProductBestSales(sender: Any?, itemChange: Any?)
}

@IBDesignable
public class UIX3ProductBestSalesView: UIX3XibView {
    public struct Defaults {
        public static let HeaderHeight = 48.0
        public static let CardHeight = 228.0
    }
    @IBOutlet public weak var neaderHeigthConstraint: NSLayoutConstraint?

    @IBOutlet public weak var captionLabel: UILabel?{
        didSet {
            self.captionLabel?.font = Config.Fonts.MarkPro(size: 25, kind: .bold)
            self.captionLabel?.textColor = Config.Colors.blue
            self.captionLabel?.text = "Best Seller".localized
        }
    }
    @IBOutlet public weak var readmoreLabel: UILabel? {
        didSet {
            self.readmoreLabel?.font = Config.Fonts.MarkPro(size: 15)
            self.readmoreLabel?.textColor = Config.Colors.tint
            self.readmoreLabel?.text = "see more".localized
            self.readmoreLabel?.isUserInteractionEnabled = true
            self.readmoreLabel?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleReadmoreClick(sender: ))))
        }
    }
    @IBOutlet public weak var collectionView: UIX3GalleryCollectionView?
    {
        didSet {
            self.collectionView?.showsHorizontalScrollIndicator = false
            self.collectionView?.showsVerticalScrollIndicator = false
            self.collectionView?.collectionViewDelegate = self
        }
    }
    public var items: [UIX3ProductBestSalesItem]? {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    public var delegate: UIX3ProductBestSalesViewDelegate?
    
    public override func setupView() {
        super.setupView()
    }
    
    @objc private func handleReadmoreClick(sender: Any?) {
        self.delegate?.ProductBestSales?(readMoreSender: self)
    }
}
extension UIX3ProductBestSalesView: UIX3CollectionViewDelegate {
    public func collectionView(setupFor collectionView: UIX3CollectionView) {
        collectionView.registerNib(UIX3ProductBestSalesCell.self)
    }
    public func collectionView(numberOfSectionsOf collectionView: UIX3CollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UIX3CollectionView, numberOfRowsInSection section: Int) -> Int {
        let _val = self.items?.count ?? 0
        return _val
    }
    public func collectionView(_ collectionView: UIX3CollectionView, rowForIndexPath indexPath: IndexPath) -> UIX3CustomCollectionCell.Type {
        return UIX3ProductBestSalesCell.self
    }
    public func collectionView(_ collectionView: UIX3CollectionView, layout: UICollectionViewLayout, sizeForCollectionCellAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((self.collectionView?.frame.width ?? 0) / 2), height: UIX3ProductBestSalesView.Defaults.CardHeight)
    }
    public func collectionView(_ collectionView: UIX3CollectionView, indexPath: IndexPath, collectionCellDidLoad cell: UICollectionViewCell?) {
        guard let _cell = cell as? UIX3ProductBestSalesCell else { return }
        _cell.item = self.items?[indexPath.row]
        _cell.onFavoriteClick = { [weak self] sender in
            guard let _item = (sender as? UIX3ProductBestSalesCell)?.item else { return }
            _item.isFavorite = !_item.isFavorite
            self?.collectionView?.reloadData()
            self?.delegate?.ProductBestSales?(sender: self, itemChange: _item)
        }
        _cell.onItemClick = { [weak self] sender in
            guard let _item = (sender as? UIX3ProductBestSalesCell)?.item else { return }
            self?.delegate?.ProductBestSales?(sender: self, itemClick: _item)
        }
    }
    public func collectionView(_ collectionView: UIX3CollectionView, willDisplay cell: UICollectionViewCell, forRowAt indexPath: IndexPath) {

    }
}
