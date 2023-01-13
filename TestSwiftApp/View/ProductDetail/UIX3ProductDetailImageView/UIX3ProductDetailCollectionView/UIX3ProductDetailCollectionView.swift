import UIKit
import x3UI

public class UIX3ProductDetailCollectionView: UIX3CollectionView {
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: SnapCenterLayout())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
