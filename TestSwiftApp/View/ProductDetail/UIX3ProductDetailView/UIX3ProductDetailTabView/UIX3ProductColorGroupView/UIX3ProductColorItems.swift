import Foundation

public class UIX3ProductColorItems: NSObject {
    public var items: [UIX3ProductColorItem] = []

    public init(listItems: [UIX3ProductColorItem]) {
        super.init()
        self.items = listItems
    }
}


public class UIX3ProductColorItem: NSObject {
    public var caption: String = ""
    public var colorName: String = ""
    public var isSelected: Bool = false
    init(caption: String, colorName: String, isSelected: Bool) {
        super.init()
        self.caption = caption
        self.colorName = colorName
        self.isSelected = isSelected
    }
}
