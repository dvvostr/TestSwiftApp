import Foundation
import x3Core
import x3UI

@objc open class UIX3CartListData: CustomDataResult {
    @objc public var basket: [UIX3CartDataItem] = Array()
//
    @objc public var id: String = ""
    @objc public var delivery: String = ""
    @objc public var total: Double = 0
//
    enum CodingKeys: String, CodingKey {
        case id
        case basket
        case delivery
        case total

    }
    public func calcTotal() -> Double {
        var _value: Double = 0
        self.basket.forEach({ _value += ($0.price * Double($0.qty)) })
        return _value
    }
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let _container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try _container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.basket = try _container.decodeIfPresent([UIX3CartDataItem].self, forKey: .basket) ?? Array()
        self.delivery = try _container.decodeIfPresent(String.self, forKey: .delivery) ?? ""
        self.total = try _container.decodeIfPresent(Double.self, forKey: .total) ?? 0
    }
    public required init(data: NSDictionary?) {
        super.init()
        self.id = (data?[CodingKeys.id.rawValue] as? String ?? "")
        self.basket.removeAll()
        for _item in data?[CodingKeys.basket.rawValue] as? NSArray ?? [] {
            self.basket.append(UIX3CartDataItem(data: _item as? NSDictionary))
        }
        self.delivery = data?[CodingKeys.delivery.rawValue] as? String  ?? ""
        self.total = (data?[CodingKeys.total.rawValue] as? Double ?? 0)
    }
    

}
    
@objc public final class UIX3CartDataItem: CustomListDataItem {
    @objc var id: Int = -1
    @objc var images: String = ""
    @objc var price: Double = 0
    @objc var qty: Int = 1
    @objc var title: String = ""

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case images = "images"
        case price = "price"
        case title = "title"
    }
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let _container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try (_container.decodeIfPresent(Int.self, forKey: .id) ?? 0)
        self.images = try (_container.decodeIfPresent(String.self, forKey: .images) ?? "")
        self.price = try (_container.decodeIfPresent(Double.self, forKey: .price) ?? 0)
        self.title = try (_container.decodeIfPresent(String.self, forKey: .title) ?? "")
        self.qty = 1
    }
    public required init(data: NSDictionary?) {
        super.init(data: data)
        self.id = (data?[CodingKeys.id.rawValue] as? Int ?? 0)
        self.images = (data?[CodingKeys.images.rawValue] as? String ?? "")
        self.price = (data?[CodingKeys.price.rawValue] as? Double ?? 0)
        self.title = (data?[CodingKeys.title.rawValue] as? String ?? "")
        self.qty = 1
    }
}
