import UIKit
import x3UI

@objc public protocol UIX3ProductHotSalesViewDelegate {
    @objc optional func ProductHotSales(readMoreSender: Any?)
    @objc optional func ProductHotSales(sender: Any?, itemBuy: Any?)
}

@IBDesignable
public class UIX3ProductHotSalesView: UIX3XibView {
    @IBOutlet public weak var captionLabel: UILabel?{
        didSet {
            self.captionLabel?.font = Config.Fonts.MarkPro(size: 25, kind: .bold)
            self.captionLabel?.textColor = Config.Colors.blue
            self.captionLabel?.text = "Hot sales".localized
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
    public var items: [UIX3ProductHomeStoreItem]? {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    public var delegate: UIX3ProductHotSalesViewDelegate?
    
    public override func setupView() {
        super.setupView()
    }
    
    @objc private func handleReadmoreClick(sender: Any?) {
        self.delegate?.ProductHotSales?(readMoreSender: self)
    }
}
extension UIX3ProductHotSalesView: UIX3CollectionViewDelegate {
    public func collectionView(setupFor collectionView: UIX3CollectionView) {
        collectionView.registerNib(UIX3ProductHotSalesCell.self)
    }
    public func collectionView(numberOfSectionsOf collectionView: UIX3CollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UIX3CollectionView, numberOfRowsInSection section: Int) -> Int {
        let _val = self.items?.count ?? 0
        return _val
    }
    public func collectionView(_ collectionView: UIX3CollectionView, rowForIndexPath indexPath: IndexPath) -> UIX3CustomCollectionCell.Type {
        return UIX3ProductHotSalesCell.self
    }
    public func collectionView(_ collectionView: UIX3CollectionView, layout: UICollectionViewLayout, sizeForCollectionCellAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView?.frame.width ?? 0, height: self.collectionView?.frame.height ?? 0)
    }
    public func collectionView(_ collectionView: UIX3CollectionView, indexPath: IndexPath, collectionCellDidLoad cell: UICollectionViewCell?) {
        guard let _cell = cell as? UIX3ProductHotSalesCell else { return }
        _cell.item = self.items?[indexPath.row]
        guard let _cell = cell as? UIX3ProductHotSalesCell else { return }
        _cell.item = self.items?[indexPath.row]
        _cell.onButtonClick = { [weak self] sender in
            guard let _item = (sender as? UIX3ProductHotSalesCell)?.item else { return }
            self?.delegate?.ProductHotSales?(sender: self, itemBuy: _item)
        }
    }
    public func collectionView(_ collectionView: UIX3CollectionView, willDisplay cell: UICollectionViewCell, forRowAt indexPath: IndexPath) {

    }
}
