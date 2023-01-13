import x3Core
import x3UI

@objc open class UIX3ProductHomeData: CustomDataResult {
    @objc public var homeStoreItems: [UIX3ProductHomeStoreItem] = Array()
    @objc public var bestSalesItems: [UIX3ProductBestSalesItem] = Array()
//
    enum CodingKeys: String, CodingKey {
        case homeStoreItems = "home_store"
        case bestSalesItems = "best_seller"
    }
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let _container = try decoder.container(keyedBy: CodingKeys.self)
        self.homeStoreItems = try _container.decodeIfPresent([UIX3ProductHomeStoreItem].self, forKey: .homeStoreItems) ?? Array()
        self.bestSalesItems = try _container.decodeIfPresent([UIX3ProductBestSalesItem].self, forKey: .bestSalesItems) ?? Array()
    }
    public required init(data: NSDictionary?) {
        super.init()
        self.homeStoreItems.removeAll()
        self.bestSalesItems.removeAll()
        for _item in data?[CodingKeys.homeStoreItems.rawValue] as? NSArray ?? [] {
            self.homeStoreItems.append(UIX3ProductHomeStoreItem(data: _item as? NSDictionary))
        }
        for _item in data?[CodingKeys.bestSalesItems.rawValue] as? NSArray ?? [] {
            self.bestSalesItems.append(UIX3ProductBestSalesItem(data: _item as? NSDictionary))
        }
    }
    open var homeStoreItemsCount: Int {
        get { return self.homeStoreItems.count }
    }
    open var bestSalesItemsCount: Int {
        get { return self.bestSalesItems.count }
    }
    
    open func item<T:UIX3ProductHomeStoreItem>(homeStoreItemIndex: Int) -> T? {
        if self.homeStoreItems.indices.contains(homeStoreItemIndex) {
            return homeStoreItems[homeStoreItemIndex] as? T
        } else {
            return nil
        }
    }
    open func item<T:CustomListDataItem>(bestSalesItemIndex: Int) -> T? {
        if self.bestSalesItems.indices.contains(bestSalesItemIndex) {
            return bestSalesItems[bestSalesItemIndex] as? T
        } else {
            return nil
        }
    }
    open func add(homeStoreItem: UIX3ProductHomeStoreItem?) {
        if let _item = homeStoreItem, self.homeStoreItems.filter({ $0.code == _item.code }).first == nil {
            self.homeStoreItems.append(_item)
        }
    }
    open func add(bestSalesItem: UIX3ProductBestSalesItem?) {
        if let _item = bestSalesItem, self.bestSalesItems.filter({ $0.code == _item.code }).first == nil {
            self.bestSalesItems.append(_item)
        }
    }
}
@objc public final class UIX3ProductHomeStoreItem: CustomListDataItem {
    @objc var id: Int = -1
    @objc var isNew: Bool = false
    @objc var title: String = ""
    @objc var subtitle: String = ""
    @objc var image: String = ""
    @objc var isBuy: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case isNew = "is_new"
        case title = "title"
        case subtitle = "subtitle"
        case image = "picture"
        case isBuy = "is_buy"
    }
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let _container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try (_container.decodeIfPresent(Int.self, forKey: .id) ?? 0)
        self.isNew = try (_container.decodeIfPresent(Bool.self, forKey: .isNew) ?? false)
        self.title = try (_container.decodeIfPresent(String.self, forKey: .title) ?? "")
        self.subtitle = try (_container.decodeIfPresent(String.self, forKey: .subtitle) ?? "")
        self.image = try _container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.isBuy = try (_container.decodeIfPresent(Bool.self, forKey: .isNew) ?? false)
    }
    public required init(data: NSDictionary?) {
        super.init(data: data)
        self.id = (data?[CodingKeys.id.rawValue] as? Int ?? 0)
        self.isNew = (data?[CodingKeys.isNew.rawValue] as? Bool ?? false)
        self.title = (data?[CodingKeys.title.rawValue] as? String ?? "")
        self.subtitle = (data?[CodingKeys.subtitle.rawValue] as? String ?? "")
        self.image = (data?[CodingKeys.image.rawValue] as? String ?? "")
        self.isBuy = (data?[CodingKeys.isBuy.rawValue] as? Bool ?? false)
    }
}
@objc public final class UIX3ProductBestSalesItem: CustomListDataItem {
    @objc var id: Int = -1
    @objc var isFavorite: Bool = false
    @objc var title: String = ""
    @objc var price: Double = 0.0
    @objc var discount: Double = 0.0
    @objc var image: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case isFavorite = "is_favorites"
        case title = "title"
        case price = "price_without_discount"
        case discount = "discount_price"
        case image = "picture"
    }
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let _container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try (_container.decodeIfPresent(Int.self, forKey: .id) ?? 0)
        self.isFavorite = try (_container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false)
        self.title = try (_container.decodeIfPresent(String.self, forKey: .title) ?? "")
        self.price = try (_container.decodeIfPresent(Double.self, forKey: .price) ?? 0)
        self.discount = try (_container.decodeIfPresent(Double.self, forKey: .discount) ?? 0)
        self.image = try (_container.decodeIfPresent(String.self, forKey: .image) ?? "")
    }
    public required init(data: NSDictionary?) {
        super.init(data: data)
        self.id = (data?[CodingKeys.id.rawValue] as? Int ?? 0)
        self.isFavorite = (data?[CodingKeys.isFavorite.rawValue] as? Bool ?? false)
        self.title = (data?[CodingKeys.title.rawValue] as? String ?? "")
        self.price = (data?[CodingKeys.price.rawValue] as? Double ?? 0)
        self.discount = (data?[CodingKeys.discount.rawValue] as? Double ?? 0)
        self.image = (data?[CodingKeys.image.rawValue] as? String ?? "")
        }
   
}
