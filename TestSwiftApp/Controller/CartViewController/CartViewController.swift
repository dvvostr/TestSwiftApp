import UIKit
import x3Core
import x3UI

class CartViewController: UIX3CustomViewController {

    @IBOutlet public weak var captionView: UIView?
    @IBOutlet public weak var captionLabel: UILabel? {
        didSet {
            self.captionLabel?.textColor = Config.Colors.blue
            self.captionLabel?.font = Config.Fonts.MarkPro(size: 32)
            self.captionLabel?.text = "My Cart".localized
        }
    }
    @IBOutlet public weak var cartView: CartView? {
        didSet{
            self.cartView?.setBorderRadius(30)
            self.cartView?.item = self.item
        }
    }
    
    lazy internal var toolsView: UIView = {
        let _view = UIView()
        let _label = UILabel()
        let _btn = UIButton.init(type: .custom)
        _view.addSubview(_label)
        _view.addSubview(_btn)
        _label.anchorCenterYToSuperview(constant: 0)
        _label.anchor(nil, left: _view.leftAnchor, bottom: nil, right: _btn.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        _btn.anchorCenterYToSuperview(constant: 0)
        _btn.anchor(nil, left: nil, bottom: nil, right: _view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: UIX3CustomViewController.Defaults.navigationBackSize, heightConstant:  UIX3CustomViewController.Defaults.navigationBackSize)

        _label.font = Config.Fonts.MarkPro(size: 15)
        _label.textColor = Config.Colors.blue
        
        _btn.setImage(Config.Images.iconLocation?.withRenderingModeTemplate, for: UIControl.State.normal)
        _btn.backgroundColor = Config.Colors.orange
        _btn.tintColor = Config.Colors.backgroundLight
        _btn.clipsToBounds = true
        _btn.layer.masksToBounds = true
        _btn.layer.cornerRadius = UIX3CustomViewController.Defaults.navigationBackRadius ?? 0
        _btn.contentEdgeInsets = UIX3CustomViewController.Defaults.navigationBackOffset
        _view.isUserInteractionEnabled = true
        _view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddAddressClick(sender:))))
        _label.text = "Add address".localized
        _view.superview?.bringSubviewToFront(_view)
        return _view
    }()

    public var item: UIX3CartListData? {
        didSet {
            self.cartView?.item = self.item
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        super.setupView()
        self.view.backgroundColor = Config.Colors.backgroundGray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.toolsView)
        self.toolsView.superview?.bringSubviewToFront(self.toolsView)
    }
    func loadData(completion: @escaping OnDataResult) {
        let _URL = "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149"
        let _ = DataController().alamofireSend(_URL, dataType: UIX3CartListData.self) { _result, _data in
            if _result.isSuccess, let _data = _data as? UIX3CartListData {
                self.item = _data
            } else {
                ShowAlertView(message: _result.errorText?.localized ?? "Unassigned error".localized, buttons: [.ok])
            }
            completion(_result, _data)
        }
    }
    @objc private func handleAddAddressClick(sender: Any?) {
        self.view.makeToast("Add address")
        
    }
}
