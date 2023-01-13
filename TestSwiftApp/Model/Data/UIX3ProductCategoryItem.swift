import x3Core
import x3UI

public var defaultProductCategoryListData: NSDictionary = ["code": "001", "caption": "Category List", "items": [
        ["code": "001", "caption": "Phones", "isSelected": 1, "imageName": "imagePhones"],
        ["code": "I02", "caption": "Computer", "isSelected": 0, "imageName": "imageComputer"],
        ["code": "I03", "caption": "Health", "isSelected": 0, "imageName": "imageHealth"],
        ["code": "I04", "caption": "Books", "isSelected": 0, "imageName": "imageBooks"],
        ["code": "I05", "caption": "Tools", "isSelected": 0, "imageName": "imageTools"],
        ["code": "I06", "caption": "Accessories", "isSelected": 0, "imageName": "imageAccessories"],
        ["code": "I07", "caption": "Toys", "isSelected": 0, "imageName": "imageToys"],
        ["code": "I08", "caption": "Other", "isSelected": 0, "imageName": "imageOther"]
    ]]


@objc final public class UIX3ProductCategoryList: CustomListDataSection {
    enum CodingKeys: String, CodingKey {
        case items
    }
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let _container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try _container.decodeIfPresent([UIX3ProductCategoryItem].self, forKey: .items) ?? Array()
    }
    public required init(data: NSDictionary?) {
        super.init(data: data)
        self.items.removeAll()
        for _item in data?["items"] as? NSArray ?? [] {
            self.items.append(UIX3ProductCategoryItem(data: _item as? NSDictionary))
        }
    }
    public override func item<T>(_ item: Int) -> T? where T : CustomListDataItem {
        if self.items.indices.contains(item) {
            return items[item] as? T
        } else {
            return nil
        }
    }
}
@objc final class UIX3ProductCategoryItem: CustomListDataItem {
    @objc var isSelected: Bool = false
    @objc var imageName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case isSelected
        case imageName
    }
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let _container = try decoder.container(keyedBy: CodingKeys.self)
        self.isSelected = try ((_container.decodeIfPresent(Int.self, forKey: .isSelected) ?? 0) == 1)
        self.imageName = try _container.decodeIfPresent(String.self, forKey: .imageName) ?? ""
    }
    public required init(data: NSDictionary?) {
        super.init(data: data)
        self.isSelected = (data?["isSelected"] as? Int ?? 0) == 1
        self.imageName = data?["imageName"] as? String ?? ""
    }
   
}
