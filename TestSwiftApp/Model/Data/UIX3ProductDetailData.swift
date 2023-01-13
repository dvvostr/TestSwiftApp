import Foundation
import x3Core
import x3UI

@objc open class UIX3ProductDetailData: CustomDataResult {
    @objc public var id: String = ""
    @objc public var title: String = ""
    @objc public var price: Double = 0
    @objc public var isFavorites: Bool = false
    @objc public var rating: Double = 0.0
    @objc public var images: [String] = Array()
    @objc public var color: [String] = Array()
    @objc public var capacity: [String] = Array()
    @objc public var CPU: String = ""
    @objc public var camera: String = ""
    @objc public var sd: String = ""
    @objc public var ssd: String = ""
//
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case isFavorites
        case rating
        case images
        case color
        case capacity
        case CPU
        case camera
        case sd
        case ssd
    }
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let _container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try _container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.title = try _container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.price = try _container.decodeIfPresent(Double.self, forKey: .price) ?? 0
        self.isFavorites = try _container.decodeIfPresent(Bool.self, forKey: .isFavorites) ?? false
        self.rating = try _container.decodeIfPresent(Double.self, forKey: .rating) ?? 0
        self.images = try _container.decodeIfPresent([String].self, forKey: .images) ?? Array()
        self.color = try _container.decodeIfPresent([String].self, forKey: .color) ?? Array()
        self.capacity = try _container.decodeIfPresent([String].self, forKey: .capacity) ?? Array()
        self.CPU = try _container.decodeIfPresent(String.self, forKey: .CPU) ?? ""
        self.camera = try _container.decodeIfPresent(String.self, forKey: .camera) ?? ""
        self.sd = try _container.decodeIfPresent(String.self, forKey: .sd) ?? ""
        self.ssd = try _container.decodeIfPresent(String.self, forKey: .ssd) ?? ""
    }
    public required init(data: NSDictionary?) {
        super.init()
        self.id = (data?[CodingKeys.id.rawValue] as? String ?? "")
        self.title = (data?[CodingKeys.title.rawValue] as? String ?? "")
        self.price = data?[CodingKeys.price.rawValue] as? Double  ?? 0
        self.isFavorites = (data?[CodingKeys.isFavorites.rawValue] as? Bool ?? false)
        self.rating = data?[CodingKeys.rating.rawValue] as? Double ?? 0
        self.images.removeAll()
        for _item in data?[CodingKeys.images.rawValue] as? NSArray ?? [] {
            if let _value = _item as? String {
                self.images.append(_value)
            }
        }
        self.color.removeAll()
        for _item in data?[CodingKeys.color.rawValue] as? NSArray ?? [] {
            if let _value = _item as? String {
                self.color.append(_value)
            }
        }
        self.capacity.removeAll()
        for _item in data?[CodingKeys.capacity.rawValue] as? NSArray ?? [] {
            if let _value = _item as? String {
                self.capacity.append(_value)
            }
        }
        self.CPU = (data?[CodingKeys.CPU.rawValue] as? String ?? "")
        self.camera = (data?[CodingKeys.camera.rawValue] as? String ?? "")
        self.sd = (data?[CodingKeys.sd.rawValue] as? String ?? "")
        self.ssd = (data?[CodingKeys.ssd.rawValue] as? String ?? "")
    }

}
    
