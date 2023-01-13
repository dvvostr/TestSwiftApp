import UIKit
import x3Core
import x3UI

class ProductDetailViewController: UIX3CustomViewController {

    lazy internal var navigationCardButton: UIBarButtonItem = {
        let _btn = UIButton.init(type: .custom)
        _btn.setImage(Config.Images.iconCard?.withRenderingModeTemplate, for: UIControl.State.normal)
        _btn.backgroundColor = Config.Colors.orange
        _btn.tintColor = Config.Colors.backgroundLight
        _btn.clipsToBounds = true
        _btn.layer.masksToBounds = true
        _btn.layer.cornerRadius = UIX3CustomViewController.Defaults.navigationBackRadius ?? 0
        _btn.frame = CGRect(x: 0, y: 3, width: UIX3CustomViewController.Defaults.navigationBackSize, height: UIX3CustomViewController.Defaults.navigationBackSize)
        _btn.contentEdgeInsets = UIX3CustomViewController.Defaults.navigationBackOffset
        _btn.addTarget(self, action: #selector(handleCardClick(sender:)), for:.touchUpInside)
        return UIBarButtonItem.init(customView: _btn)
    }()
    
    @IBOutlet public weak var productImageView: UIX3ProductDetailImageView? {
        didSet {
            self.productImageView?.items = self.item?.images
        }
    }
    @IBOutlet public weak var productDetailView: UIX3ProductDetailView? {
        didSet {
            self.productDetailView?.item = self.item
        }
    }
    @IBOutlet public weak var productDetailViewHeigthConstraint: NSLayoutConstraint? {
        didSet {
            self.productDetailViewHeigthConstraint?.constant = UIX3ProductDetailView.Defaults.Height
        }
    }
    public var item: UIX3ProductDetailData? {
        didSet {
            self.productDetailView?.item = self.item
            self.productImageView?.items = self.item?.images
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setupView() {
        super.setupView()
        self.navigationItem.rightBarButtonItems = [navigationCardButton]
        self.view.backgroundColor = Config.Colors.backgroundGray
    }
    func loadData(completion: @escaping OnDataResult) {
        let _URL = "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5"
        let _ = DataController().alamofireSend(_URL, dataType: UIX3ProductDetailData.self) { _result, _data in
            if _result.isSuccess, let _data = _data as? UIX3ProductDetailData {
                self.item = _data
            } else {
                ShowAlertView(message: _result.errorText?.localized ?? "Unassigned error".localized, buttons: [.ok])
            }
            completion(_result, _data)
        }
    }
    @objc private func handleCardClick(sender: Any?) {
        let _vc = CartViewController()
        _vc.loadData() { _result, _data in
            if _result.isSuccess {
                self.navigationController?.pushViewController(_vc, animated: true)
            }
        }
    }
}
