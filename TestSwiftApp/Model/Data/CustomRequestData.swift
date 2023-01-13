import Foundation
import Alamofire

struct CustomRequestDataValue<T> {
    var value: T
}

class CustomRequestParams: Encodable {
}

class CustomRequestData: Encodable {
    public var bundleID: String = ""
    public var deviceId: String = ""
    public var method: String = ""
    public var params: CustomRequestParams?
    init(method: String) {
        self.bundleID = Device.BundleID
        self.deviceId = Device.ID
        self.method = method
    }
    open func getParams<T: CustomRequestParams>(_ paramClass: T.Type) -> T {
        return params as! T
    }
    func asParameters() throws -> Parameters {
        let _data = try JSONEncoder().encode(self)
        guard let _dictionary = try JSONSerialization.jsonObject(with: _data, options: .allowFragments) as? Parameters else {
            throw NSError()
        }
        return _dictionary
    }
}


