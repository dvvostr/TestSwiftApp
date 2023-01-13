import UIKit
import x3Core
import x3UI

@IBDesignable
class HomeViewController: UIViewController {
    @IBOutlet public weak var testLabel: UILabel?
    @IBOutlet public weak var scrollView: UIScrollView?
    @IBOutlet public weak var scrollContainerView: UIView?
    @IBOutlet public weak var scrollViewHeigthConstraint: NSLayoutConstraint?
    @IBOutlet public weak var productCategoryView: UIX3ProductCategorySelectView?{
        didSet {
            self.productCategoryView?.delegate = self
        }
    }
    @IBOutlet public weak var productSearchView: UIX3ProductSearchView? {
        didSet {}
    }
    @IBOutlet public weak var productHotSalesView: UIX3ProductHotSalesView? {
        didSet {
            self.productHotSalesView?.delegate = self
        }
    }
    @IBOutlet public weak var productBestSalesView: UIX3ProductBestSalesView? {
        didSet {
            self.productBestSalesView?.delegate = self
        }
    }
    @IBOutlet public weak var productNavBarView: UIX3ProductNavBarView? {
        didSet {
            self.productNavBarView?.containerView?.layer.cornerRadius = 34.0
        }
    }
    
    public struct Defaults {
        public static let locationName = "Zihuatanejo, Grocery Stores"
        public static let headerLocationWidth = 220.0
        public static let headerLocationHeight = 44.0
    }
    
    private lazy var headerLocationView: UIX3NavLocationView = {
        let _view = UIX3NavLocationView()
        _view.delegate = self
        _view.label?.font = Config.Fonts.MarkPro(size: 15)
        _view.label?.textColor = Config.Colors.blue
        _view.label?.text = HomeViewController.Defaults.locationName
        _view.imageLeft?.tintColor = Config.Colors.orange
        _view.imageLeft?.image = Config.Images.iconLocation?.withRenderingModeTemplate
        _view.imageRight?.tintColor = Config.Colors.gray
        _view.imageRight?.image = Config.Images.iconChevronDown?.withRenderingModeTemplate
        _view.superview?.bringSubviewToFront(_view)
        return _view
    }()
    private lazy var productFilterView: UIX3ProductFilterView = {
        let _view = UIX3ProductFilterView()
        _view.captionFont = Config.Fonts.MarkPro(size: 18)
        _view.delegate = self
        return _view
    }()
    public lazy var filterButton: UIBarButtonItem = {
        let _btn = UIX3CustomNavigaionButton(image: Config.Images.iconFilter!.withRenderingModeTemplate)
        _btn.addTarget(self, action: #selector(handleFilterButtonClick(sender:)), for:.touchUpInside)
        _btn.tintColor = Config.Colors.blue
        return UIBarButtonItem.init(customView: _btn)
    }()
// MARK: - Propertyes
    private var headerLocationWidth: CGFloat? {
        didSet {
            let _value: CGFloat = headerLocationWidth ?? HomeViewController.Defaults.headerLocationWidth
            if let _constraint = self.headerLocationView.getContraint(attribute: .width, relation: nil) {
                _constraint.constant = _value
                _constraint.isActive = true
            } else {
                self.headerLocationView.widthAnchor.constraint(equalToConstant: _value).isActive = true
            }
        }
    }
    private var headerLocationHeight: CGFloat? {
        didSet {
            let _value: CGFloat = headerLocationHeight ?? HomeViewController.Defaults.headerLocationHeight
            if let _constraint = self.headerLocationView.getContraint(attribute: .height, relation: nil) {
                _constraint.constant = _value
                _constraint.isActive = true
            } else {
                self.headerLocationView.heightAnchor.constraint(equalToConstant: _value).isActive = true
            }
        }
    }
    public var locationName: String?  {
        didSet {
            self.headerLocationView.label?.text = self.locationName
        }
    }
    public var items: UIX3ProductHomeData? {
        didSet {
            self.productHotSalesView?.items = self.items?.homeStoreItems
            self.productBestSalesView?.items = self.items?.bestSalesItems
            self.scrollViewHeigthConstraint?.constant = calcScrollViewHeigth()
        }
    }
// MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    func setupView() {
        self.headerLocationWidth = HomeViewController.Defaults.headerLocationWidth
        self.headerLocationHeight = HomeViewController.Defaults.headerLocationHeight
        self.navigationItem.titleView = headerLocationView
        self.navigationItem.rightBarButtonItem = self.filterButton
        self.view.backgroundColor = Config.Colors.backgroundGray
        self.loadProductData()
    }
    private func loadProductData(){
        let _URL = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
        let _ = DataController().alamofireSend(_URL, dataType: UIX3ProductHomeData.self) { _result, _data in
            if _result.isSuccess, let _data = _data as? UIX3ProductHomeData {
                self.items = _data
            } else {
                ShowAlertView(message: _result.errorText?.localized ?? "Unassigned error".localized, buttons: [.ok])
            }
        }
    }
// MARK: - handles
    @objc private func handleFilterButtonClick(sender: Any?) {
        let _vc = UIX3ModalCardViewController()
        _vc.show(self.productFilterView, atState: .compact, atHeigth: UIX3ProductFilterView.Defaults.Heigth)
    }
    @objc private func handleTest(sender: Any?) {
        ShowAlertView(message: "TEST", buttons: [.ok])
    }
    private func calcScrollViewHeigth() -> CGFloat {
        guard let _frameBestSales = productBestSalesView?.frame, let _count = self.items?.bestSalesItems.count else { return 0.0 }
        let _val = UIX3ProductBestSalesView.Defaults.HeaderHeight + (UIX3ProductBestSalesView.Defaults.CardHeight * Double(((_count / 2) + (_count % 2))))
        return _frameBestSales.origin.y + _val + 22.0
    }
    private func openProductDetail(_ code: Int, title: String) {
        let _vc = ProductDetailViewController.fromNib()
        _vc.captionFont = Config.Fonts.MarkPro(size: 18) ?? UIFont.systemFont(ofSize: 18)
        _vc.captionText = "Product details".localized
        _vc.loadData() { _result, _data in
            if _result.isSuccess {
                self.navigationController?.pushViewController(_vc, animated: true)
            }
        }
    }
}

// MARK: - Delegates
extension HomeViewController:
                        UIX3NavLocationViewDelegate,
                        UIX3ProductFilterViewDelegate,
                        UIX3ProductCategorySelectViewDelegate,
                        UIX3ProductHotSalesViewDelegate,
                        UIX3ProductBestSalesViewDelegate {
    // MARK: - UIX3NavLocationViewDelegate
    func NavLocationViewClick(sender: Any?) {
        self.view.makeToast("Navigation Location View Click")
    }
    // MARK: - UIX3ProductFilterViewDelegate
    @objc func ProductFilterViewCancel(sender: Any?) {
        self.view.makeToast("Product Filter View Cancel")
    }
    @objc func ProductFilterViewDone(sender: Any?, values: Any?) {
        guard let _obj = sender as? UIX3ProductFilterView else { return }
        ShowAlertView(message: "\(_obj.fieldValue1?.caption ?? "<?>") = \(_obj.fieldValue1?.value ?? "<?>") \n\(_obj.fieldValue2?.caption ?? "<?>") = \(_obj.fieldValue2?.value ?? "<?>") \n\(_obj.fieldValue3?.caption ?? "<?>") = \(_obj.fieldValue3?.value ?? "<?>")", buttons: [.ok])
    }
    // MARK: - UIX3ProductCategorySelectViewDelegate
    func ProductCategorySelectView(sender: Any?, selectAll: Bool) {
        self.view.makeToast("Product Category Select All")
    }
    func ProductCategorySelectView(sender: Any?, clickItem: Any?) {
        guard let _item = clickItem as? UIX3ProductCategoryItem else { return }
        self.view.makeToast("Item click: \(_item.caption)")
    }
    // MARK: - UIX3ProductHotSalesViewDelegate
    func ProductHotSales(readMoreSender: Any?) {
        self.view.makeToast("Product Hot Sales read more")
        print("\(6 / 2) - \(6 % 2) - \(Int(5.0).isMultiple(of: 2))")
    }
    func ProductHotSales(sender: Any?, itemBuy: Any?) {
        guard let _item = itemBuy as? UIX3ProductHomeStoreItem else { return }
        self.view.makeToast("Item buy: \(_item.id) : \(_item.title)")
    }
    // MARK: - UIX3ProductBestSalesViewDelegate
    func ProductBestSales(readMoreSender: Any?) {
        self.view.makeToast("Product Best Sales read more")
    }
    func ProductBestSales(sender: Any?, itemClick: Any?) {
        guard let _item = itemClick as? UIX3ProductBestSalesItem else { return }
        self.openProductDetail(_item.id, title: _item.title)
    }
    func ProductBestSales(sender: Any?, itemChange: Any?) {
        guard let _item = itemChange as? UIX3ProductBestSalesItem else { return }
        self.view.makeToast("Item change: \(_item.id) : \(_item.title)")
    }
}

