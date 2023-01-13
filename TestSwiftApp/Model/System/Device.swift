import UIKit

public class Device {
    public static var pushToken: String = ""

    public static let ID: String = {
        return UIDevice.current.identifierForVendor!.uuidString
    }()
    public static let shortVersion: String = {
        if let _str = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String{
            return _str
        } else {
            return ""
        }
    }()
    public static let version: String = {
        if let _str = Bundle.main.infoDictionary?["CFBundleVersion"] as? String{
            return String(format: "%@.%@", Device.shortVersion, _str)
        } else {
            return ""
        }
    }()
    public static let model: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }()
    public static let versionOS: String = {
        return UIDevice.current.systemVersion
    }()
    public static let BundleID: String = {
        return Bundle.main.bundleIdentifier!
    }()
    public static let decimalSeparator: Character = {
        if let _chr = Array(NumberFormatter().decimalSeparator).first{
            return _chr
        } else {
            return "."
        }
    }()

}
