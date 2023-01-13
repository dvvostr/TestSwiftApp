import UIKit
import x3Core
import x3UI
import Nuke

class UIX3ProductDetailImageCell: UIX3CustomCollectionCell {
    @IBOutlet public weak var imageView: UIImageView? {
        didSet {
            self.imageView?.backgroundColor = .clear
        }
    }
    public var item: String? {
        didSet {
            var _options = ImageLoadingOptions(
                placeholder: nil,
                transition: .fadeIn(duration: 0.25),
                failureImage: nil
            )
            _options.pipeline = Nuke.ImagePipeline.shared
            let _URL = URL(string: self.item ?? "NONE")!
            if let _picture = self.imageView {
                DispatchQueue.main.async {
                    Nuke.loadImage(with: _URL, options: _options, into: _picture)
                }
            }
        }
    }
    override func setupView() {
        super.setupView()
    }

}
