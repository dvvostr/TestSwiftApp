import UIKit
import x3UI


@objc public protocol UIX3ProductDetailImageViewDelegate {
    @objc optional func ProductDetailImage(readMoreSender: Any?)
    @objc optional func ProductDetailImage(sender: Any?, itemClick: Any?)
    @objc optional func ProductDetailImage(sender: Any?, itemChange: Any?)
}
public class UIX3ProductDetailImageView: UIX3XibView {
    public struct Defaults {
        public static let HeaderHeight = 48.0
        public static let CardHeight = 228.0
    }
    @IBOutlet public weak var collectionView: UIX3ProductDetailCollectionView? {
        didSet {
            collectionView?.collectionViewDelegate = self
        }
    }
    public var items: [String]? {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    public override func setupView() {
        super.setupView()
    }
}

extension UIX3ProductDetailImageView: UIX3CollectionViewDelegate {
    public func collectionView(setupFor collectionView: UIX3CollectionView) {
        collectionView.registerNib(UIX3ProductDetailImageCell.self)
    }
    public func collectionView(numberOfSectionsOf collectionView: UIX3CollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UIX3CollectionView, numberOfRowsInSection section: Int) -> Int {
        let _val = self.items?.count ?? 0
        return _val
    }
    public func collectionView(_ collectionView: UIX3CollectionView, rowForIndexPath indexPath: IndexPath) -> UIX3CustomCollectionCell.Type {
        return UIX3ProductDetailImageCell.self
    }
    public func collectionView(_ collectionView: UIX3CollectionView, layout: UICollectionViewLayout, sizeForCollectionCellAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((self.collectionView?.frame.width ?? 0) - 100 ), height: self.collectionView?.frame.height ?? 0)
    }
    public func collectionView(_ collectionView: UIX3CollectionView, indexPath: IndexPath, collectionCellDidLoad cell: UICollectionViewCell?) {
        guard let _cell = cell as? UIX3ProductDetailImageCell else { return }
        _cell.item = self.items?[indexPath.row]
    }
    public func collectionView(_ collectionView: UIX3CollectionView, willDisplay cell: UICollectionViewCell, forRowAt indexPath: IndexPath) {

    }

}
