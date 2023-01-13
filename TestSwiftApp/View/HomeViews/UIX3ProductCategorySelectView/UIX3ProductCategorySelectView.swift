import UIKit
import x3UI

@objc public protocol UIX3ProductCategorySelectViewDelegate {
    @objc optional func ProductCategorySelectView(sender: Any?, selectAll: Bool)
    @objc optional func ProductCategorySelectView(sender: Any?, clickItem: Any?)
}

@IBDesignable
public class UIX3ProductCategorySelectView: UIX3XibView {
    public struct Defaults {
        public static let Width = 82.0
        public static let Height = 92.0
    }
    
    @IBOutlet public weak var captionView: UIView?
    @IBOutlet public weak var captionLabel: UILabel?
    @IBOutlet public weak var selectAllLabel: UILabel?
    @IBOutlet public weak var collectionView: UIX3CollectionView?
    
    public var delegate: UIX3ProductCategorySelectViewDelegate?

    public var items: UIX3ProductCategoryList = UIX3ProductCategoryList.init(data: defaultProductCategoryListData)
    
    public override func setupView() {
        super.setupView()
        self.captionLabel?.font = Config.Fonts.MarkPro(size: 27, kind: .bold, type: .regular)
        self.captionLabel?.textColor = Config.Colors.blue
        self.captionLabel?.text = "Select Category".localized

        self.selectAllLabel?.font = Config.Fonts.MarkPro(size: 15, kind: .light)
        self.selectAllLabel?.textColor = Config.Colors.tint
        self.selectAllLabel?.text = "view all".localized
        self.selectAllLabel?.isUserInteractionEnabled = true
        self.selectAllLabel?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectAllClick(sender: ))))

        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.collectionViewDelegate = self
    }
    
    @objc private func handleSelectAllClick(sender: Any?) {
        self.delegate?.ProductCategorySelectView?(sender: self, selectAll: true)
    }
}
extension UIX3ProductCategorySelectView: UIX3CollectionViewDelegate {
    public func collectionView(setupFor collectionView: UIX3CollectionView) {
        collectionView.registerNib(UIX3ProductCategorySelectCell.self)
    }
    public func collectionView(numberOfSectionsOf collectionView: UIX3CollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UIX3CollectionView, numberOfRowsInSection section: Int) -> Int {
        return self.items.itemCount
    }

    public func collectionView(_ collectionView: UIX3CollectionView, rowForIndexPath indexPath: IndexPath) -> UIX3CustomCollectionCell.Type {
        return UIX3ProductCategorySelectCell.self
    }
    public func collectionView(_ collectionView: UIX3CollectionView, layout: UICollectionViewLayout, sizeForCollectionCellAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIX3ProductCategorySelectView.Defaults.Width, height: UIX3ProductCategorySelectView.Defaults.Height)
    }
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {     }
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { }
    
    public func collectionView(_ collectionView: UIX3CollectionView, indexPath: IndexPath, collectionCellDidLoad cell: UICollectionViewCell?) {
        guard let _cell = cell as? UIX3ProductCategorySelectCell else { return }
        _cell.item = self.items.items[indexPath.row] as? UIX3ProductCategoryItem
        _cell.onClick = { [weak self] sender in
            guard let _item = (sender as? UIX3ProductCategorySelectCell)?.item else { return }
            self?.items.items.forEach({ ($0 as? UIX3ProductCategoryItem)?.isSelected = ($0 == _item) })
            self?.collectionView?.reloadData()
            self?.delegate?.ProductCategorySelectView?(sender: self, clickItem: _item)
        }
    }
    public func collectionView(_ collectionView: UIX3CollectionView, willDisplay cell: UICollectionViewCell, forRowAt indexPath: IndexPath) {

    }
//    public func collectionView(headerViewFor collectionView: UIX3CollectionView) -> UIX3CustomCollectionHeaderFooterView.Type {}
//    public func collectionView(_ collectionView: UIX3CollectionView, heightForCollectionHeaderInSection section: Int) -> CGFloat {}
//    public func collectionView(_ collectionView: UIX3CollectionView, section: Int, collectionHeaderDidLoad view: UIView?) {}
}
