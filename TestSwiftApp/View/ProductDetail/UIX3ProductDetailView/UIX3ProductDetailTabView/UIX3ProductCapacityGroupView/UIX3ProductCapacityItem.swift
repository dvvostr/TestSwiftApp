import Foundation

public class UIX3ProductCapacityItem: NSObject {
    public var caption: String = ""
    public var isSelected: Bool = false
    init(caption: String, isSelected: Bool) {
        super.init()
        self.caption = caption
        self.isSelected = isSelected
    }
}
