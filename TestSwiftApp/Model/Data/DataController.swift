import Foundation
import x3Core
import x3UI
import Alamofire

class DataController: NSObject {
    public static var userName: String?
    public static var password: String?
    override init() {
        
    }
    deinit {
        
    }
    public func alamofireSend<T: CustomDataResult>(_ url: String, dataType: T.Type? = nil, completion: @escaping OnDataResult) -> Bool {
        let _URL = "\(url)"
        var headers: HTTPHeaders = [
            "Accept": "application/json",
            "X-Key": Device.ID.data(using: String.Encoding.utf8)!.base64EncodedString()
        ]
        if let _userName = DataController.userName, let _password = DataController.password {
            headers.add(HTTPHeader(name: "Authorization", value: "Basic \(String(format: "%@:%@", _userName, _password).data(using: String.Encoding.utf8)!.base64EncodedString())"))
        }
        AF.request(
            _URL,
            method: .get,
            parameters: nil,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .response { response in
            if DEBUG_PRINT {
                if let _data = response.data {
                    print("RESPONSE: \(_URL)\n\(String(data: _data, encoding: .utf8)!)")
                } else {
                    print("RESPONSE: \(_URL)\n\("Data empty".localized)")
                }
            }
            switch response.result {
            case .success:
                guard let _data = response.data else {
                    completion(DataResult.errorText("Data empty".localized), nil)
                    return
                }
                if let _obj = try? JSONDecoder().decode(T.self, from: _data) {
                    completion(DataResult.success, _obj)
                } else {
                    completion(DataResult.errorText("Data empty".localized), nil)
                }
            case let .failure(error): completion(.errorText(error.localizedDescription), nil)
            }
        }
        return true
    }
}
