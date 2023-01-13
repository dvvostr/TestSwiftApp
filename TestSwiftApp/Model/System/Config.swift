import UIKit
import x3Core
import x3UI

// MARK: - ******* CONFIG *******
public let DEBUG_PRINT = true
public let DEBUG_URL = "https://dvostr.ru/data/execute"

public protocol CustomDefaultProtocol {
    static func initialize()
}


public struct Config: CustomDefaultProtocol {
    public static func initialize() {
        Config.Colors.initialize()
        Config.Fonts.initialize()
        Config.Images.initialize()
        Config.AlertViewController.initialize()
        UIX3CustomViewController.Defaults.navigationBackImage = Config.Images.iconChevronBack
        UIX3CustomViewController.Defaults.navigationBackTintColor = Config.Colors.backgroundLight
        UIX3CustomViewController.Defaults.navigationBackBackgroundColor = Config.Colors.blue
        UIX3CustomViewController.Defaults.navigationBackRadius = 6.0
    }
// MARK: - ******* COLORS *******
    public struct Colors: CustomDefaultProtocol {
        public static func initialize() {
        }
        public struct Names {
            public static let colorBackgroundGray = "colorBackgroundGray"
            public static let colorBackgroundLight = "colorBackgroundLight"
            public static let colorBlue = "colorBlue"
            public static let colorGray = "colorGray"
            public static let colorOrange = "colorOrange"
            public static let colorYellow = "colorYellow"
            public static let colorDarkGray = "colorDarkGray"
        }
        public static let backgroundGray = UIColor(named: Config.Colors.Names.colorBackgroundGray) ?? UIColor.clear
        public static let backgroundLight = UIColor(named: Config.Colors.Names.colorBackgroundLight) ?? UIColor.clear
        public static let blue = UIColor(named: Config.Colors.Names.colorBlue) ?? UIColor.clear
        public static let gray = UIColor(named: Config.Colors.Names.colorGray) ?? UIColor.clear
        public static let darkGray = UIColor(named: Config.Colors.Names.colorDarkGray) ?? UIColor.clear
        public static let orange = UIColor(named: Config.Colors.Names.colorOrange) ?? UIColor.clear
        public static let yellow = UIColor(named: Config.Colors.Names.colorYellow) ?? UIColor.clear
        public static let tint = UIColor(named: Config.Colors.Names.colorOrange) ?? UIColor.clear
    }
// MARK: - ******* FONTS *******
    public struct Fonts: CustomDefaultProtocol {
        private static let FONT_MARKPRO_REGULAR = "MarkPro"
        private static let FONT_MARKPRO_BLACK = "MarkPro-Black"
        private static let FONT_MARKPRO_BLACKIT = "MarkPro-BlackItalic"
        private static let FONT_MARKPRO_BOLD = "MarkPro-Bold"
        private static let FONT_MARKPRO_BOLDIT = "MarkPro-BoldItalic"
        private static let FONT_MARKPRO_BOOK = "MarkPro-Book"
        private static let FONT_MARKPRO_BOOKIT = "MarkPro-BookItalic"
        private static let FONT_MARKPRO_EXTRALIGHT = "MarkPro-ExtraLight"
        private static let FONT_MARKPRO_EXTRALIGHTIT = "MarkPro-ExtraLightItalic"
        private static let FONT_MARKPRO_HAIRLINE = "MarkPro-Hairline"
        private static let FONT_MARKPRO_HAIRLINEIT = "MarkPro-HairlineItalic"
        private static let FONT_MARKPRO_HEAVI = "MarkPro-Heavy"
        private static let FONT_MARKPRO_HEAVIIT = "MarkPro-HeavyItalic"
        private static let FONT_MARKPRO_ITALIC = "MarkPro-Italic"
        private static let FONT_MARKPRO_LIGHT = "MarkPro-Light"
        private static let FONT_MARKPRO_LIGHTIT = "MarkPro-LightItalic"
        private static let FONT_MARKPRO_MEDIUM = "MarkPro-Medium"
        private static let FONT_MARKPRO_MEDIUMIT = "MarkPro-MediumItalic"
        private static let FONT_MARKPRO_THIN = "MarkPro-Thin"
        private static let FONT_MARKPRO_THINIT = "MarkPro-ThinItalic"
        
        public static func initialize() {
        }
        public static func MarkPro(size: CGFloat, kind: UIFontKind = .regular, type: UIFontType = .regular) -> UIFont?{
            switch kind {
            case .black:
                if type == .italic {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_BLACKIT, size: size)
                } else {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_BLACK, size: size)
                }
            case .bold:
                if type == .italic {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_BOLDIT, size: size)
                } else {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_BOLD, size: size)
                }
            case .book:
                if type == .italic {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_BOOKIT, size: size)
                } else {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_BOOK, size: size)
                }
            case .extralight:
                if type == .italic {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_EXTRALIGHTIT, size: size)
                } else {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_EXTRALIGHT, size: size)
                }
            case .hairline:
                if type == .italic {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_HAIRLINEIT, size: size)
                } else {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_HAIRLINE, size: size)
                }
            case .heavy:
                if type == .italic {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_HEAVIIT, size: size)
                } else {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_HEAVI, size: size)
                }
            case .light:
                if type == .italic {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_LIGHTIT, size: size)
                } else {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_LIGHT, size: size)
                }
            case .medium:
                if type == .italic {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_MEDIUMIT, size: size)
                } else {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_MEDIUM, size: size)
                }
            case .thin:
                if type == .italic {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_THINIT, size: size)
                } else {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_THIN, size: size)
                }
            default:
                if type == .italic {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_ITALIC, size: size)
                } else {
                    return UIFont(name: Config.Fonts.FONT_MARKPRO_REGULAR, size: size)
                }
            }
        }
    }
    
// MARK: - ******* IMAGES *******
    public struct Images: CustomDefaultProtocol {
        public static func initialize() {
            UINavigationBar.appearance().backIndicatorImage = Config.Images.iconChevronBack?.withRenderingOriginal
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = Config.Images.iconChevronBack?.withRenderingOriginal
            
            UIX3CustomControl.Defaults.Color.background = Config.Colors.backgroundLight
            
        }
        
        public static let IMAGE_ICONCANCEL = "iconCancel"
        public static let IMAGE_ICONCARD = "iconCard"
        public static let IMAGE_ICONCATEGORY = "iconCategory"
        public static let IMAGE_ICONCHECKED = "iconChecked"
        public static let IMAGE_ICONCHEVRONBACK = "iconChevronBack"
        public static let IMAGE_ICONCHEVRONDOWN = "iconChevronDown"
        public static let IMAGE_ICONCIRCLE = "iconCircle"
        public static let IMAGE_ICONFAVORITEOFF = "iconFavoriteOff"
        public static let IMAGE_ICONFAVORITEON = "iconFavoriteOn"
        public static let IMAGE_ICONFILTER = "iconFilter"
        public static let IMAGE_ICONLOCATION = "iconLocation"
        public static let IMAGE_ICONSEARCH = "iconSearch"
        public static let IMAGE_ICONTRASHBIN = "iconTrashBin"
        public static let IMAGE_ICONSTAR = "iconStar"
        public static let IMAGE_ICONUSER = "iconUser"

        public static var iconCancel: UIImage? { get { return UIImage(named: IMAGE_ICONCANCEL) } }
        public static var iconCard: UIImage? { get { return UIImage(named: IMAGE_ICONCARD) } }
        public static var iconCategory: UIImage? { get { return UIImage(named: IMAGE_ICONCATEGORY) } }
        public static var iconChecked: UIImage? { get { return UIImage(named: IMAGE_ICONCHECKED) } }
        public static var iconChevronBack: UIImage? { get { return UIImage(named: IMAGE_ICONCHEVRONBACK) } }
        public static var iconChevronDown: UIImage? { get { return UIImage(named: IMAGE_ICONCHEVRONDOWN) } }
        public static var iconCircle: UIImage? { get { return UIImage(named: IMAGE_ICONCIRCLE) } }
        public static var iconFavoriteOff: UIImage? { get { return UIImage(named: IMAGE_ICONFAVORITEOFF) } }
        public static var iconFavoriteOn: UIImage? { get { return UIImage(named: IMAGE_ICONFAVORITEON) } }
        public static var iconFilter: UIImage? { get { return UIImage(named: IMAGE_ICONFILTER) } }
        public static var iconLocation: UIImage? { get { return UIImage(named: IMAGE_ICONLOCATION) } }
        public static var iconSearch: UIImage? { get { return UIImage(named: IMAGE_ICONSEARCH) } }
        public static var iconTrashBin: UIImage? { get { return UIImage(named: IMAGE_ICONTRASHBIN) } }
        public static var iconStar: UIImage? { get { return UIImage(named: IMAGE_ICONSTAR) } }
        public static var iconUser: UIImage? { get { return UIImage(named: IMAGE_ICONUSER) } }
    }
// MARK: - ******* ALERT VIEW *******
    public struct AlertViewController: CustomDefaultProtocol {
        public static func initialize() {
            UIX3AlertViewController.Defaults.Color.background = UIX3CustomControl.Defaults.Color.text?.withAlphaComponent(0.6)
            UIX3CustomAlertViewController.Defaults.AlertView.Color.background = Config.Colors.backgroundLight
            UIX3AlertViewController.Defaults.AlertView.Color.message = UIColor.black
            UIX3AlertViewController.Defaults.AlertView.Color.caption = UIColor.black
            UIX3CustomAlertViewController.Defaults.AlertView.height = 12.0
            UIX3CustomAlertViewController.Defaults.AlertView.width = 280.0
            UIX3AlertViewController.Defaults.AlertView.imageSize = 36.0
            UIX3AlertViewController.Defaults.AlertView.headerFont = Config.Fonts.MarkPro(size: 16)
            UIX3AlertViewController.Defaults.AlertView.messageFont = Config.Fonts.MarkPro(size: 14)
            UIX3AlertViewController.Defaults.AlertView.buttonOKSettings = UX3CustomButton.Defaults.settings
            UIX3AlertViewController.Defaults.AlertView.buttonOKSettings?.caption = "OK".localized
            UIX3AlertViewController.Defaults.AlertView.buttonOKSettings?.borderRadius = -1

            UIX3AlertViewController.Defaults.AlertView.buttonOKSettings = UX3CustomButtonSettings(
                normalColor: UX3CustomButtonSettings.Color(
                    background: Config.Colors.tint,
                    foreground: Config.Colors.backgroundLight,
                    border: Config.Colors.tint
                ), selectedColor: UX3CustomButtonSettings.Color(
                    background: Config.Colors.backgroundGray,
                    foreground: Config.Colors.tint,
                    border: Config.Colors.tint
                ),
                caption: "Cancel".localized
            )
            UIX3AlertViewController.Defaults.AlertView.buttonCancelSettings = UX3CustomButtonSettings(
                normalColor: UX3CustomButtonSettings.Color(
                    background: UIColor.clear,
                    foreground: Config.Colors.tint,
                    border: Config.Colors.tint
                ), selectedColor: UX3CustomButtonSettings.Color(
                    background: Config.Colors.tint,
                    foreground: Config.Colors.backgroundLight,
                    border: Config.Colors.tint
                ),
                caption: "Cancel".localized
            )
            UIX3AlertViewController.Defaults.AlertView.buttonHelpSettings = UX3CustomButtonSettings(
                normalColor: UX3CustomButtonSettings.Color(
                    background: UIColor.clear,
                    foreground: Config.Colors.tint,
                    border: UIColor.clear
                ), selectedColor: UX3CustomButtonSettings.Color(
                    background: UIColor.clear,
                    foreground: Config.Colors.backgroundGray,
                    border: UIColor.clear
                )
            )
//            UIX3AlertViewController.Defaults.AlertView.buttonHelpSettings?.image = Config.Images.iconHelp1?.withRenderingModeTemplate
        }
            
    }
}
