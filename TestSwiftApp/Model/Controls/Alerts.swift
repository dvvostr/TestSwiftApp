import UIKit
import x3Core
import x3UI

private var waitViewController: UIX3WaitViewController?

public func ShowAlertView(_ caption: String? = nil, message: String, image: UIImage? = nil, buttons: UIX3CustomAlertButtonOptions = .default, onOKEvent: ObjectEvent? = nil, onCancelEvent: ObjectEvent? = nil, onHelpEvent: ObjectEvent? = nil) {
    _ = GetAlertView(caption, message: message, image: image, buttons: buttons, onOKEvent: onOKEvent, onCancelEvent: onCancelEvent, onHelpEvent: onCancelEvent)
}
public func GetAlertView(_ caption: String? = nil, message: String, image: UIImage? = nil, buttons: UIX3CustomAlertButtonOptions = .default, onOKEvent: ObjectEvent? = nil, onCancelEvent: ObjectEvent? = nil, onHelpEvent: ObjectEvent? = nil) -> UIX3AlertViewController {
    let _vc = UIX3AlertViewController()
    _vc.borderWidth = 0
    _vc.cornerRadius = 12
    _vc.caption = caption
    _vc.message = message
    _vc.alertSize = .percent
    _vc.alertWidth = 80
    _vc.image = image
    _vc.buttonOptions = buttons
    _vc.buttonOKHelper = onOKEvent
    _vc.buttonCancelHelper = onCancelEvent
    _vc.buttonHelpHelper = onHelpEvent
    _vc.show()
    return _vc
}

public func ShowAlertView(_ caption: String? = nil, text: NSAttributedString, image: UIImage? = nil, buttons: UIX3CustomAlertButtonOptions = .default, onOKEvent: ObjectEvent? = nil, onCancelEvent: ObjectEvent? = nil, onHelpEvent: ObjectEvent? = nil) {
    let _vc = UIX3AlertViewController()
    _vc.borderWidth = 0
    _vc.cornerRadius = 12
    _vc.caption = caption
    _vc.messageAttributedString = text
    _vc.alertSize = .percent
    _vc.alertWidth = 80
    _vc.image = image
    
    _vc.buttonOptions = buttons
    _vc.buttonOKHelper = onOKEvent
    _vc.buttonCancelHelper = onCancelEvent
    _vc.buttonHelpHelper = onHelpEvent
    _vc.show()
}


public func ShowWrapperView(_ content: UIView? = nil, buttons: UIX3CustomAlertButtonOptions = .default, onOKEvent: ObjectEvent? = nil) {
    let _vc = UIX3AlertWrapperViewController()
    _vc.borderWidth = 0
    _vc.cornerRadius = 12
    _vc.alertSize = .percent
    _vc.alertWidth = 85
    _vc.alertHeight = 75
    _vc.buttonOptions = buttons
    _vc.buttonOKSettings?.borderRadius = 8
    _vc.buttonCancelSettings?.borderRadius = 8
    _vc.buttonCancelSettings?.normalColor.border = UIColor.clear
    _vc.buttonCancelSettings?.selectedColor.border = UIColor.clear
    _vc.buttonCancelSettings?.selectedColor.background = UIColor.clear
    _vc.contentView = content
    _vc.buttonOKHelper = onOKEvent
    if let _color = _vc.buttonCancelSettings?.normalColor.foreground {
        _vc.buttonCancelSettings?.selectedColor.foreground = _color.getAlphaColor(0.4)
    }
    _vc.show()
}

public func showWaitView(title: String? = nil) {
    waitViewController = UIX3WaitViewController()
    waitViewController?.borderWidth = 0
    waitViewController?.cornerRadius = 12
    waitViewController?.windowBackgroundColor = UIColor.black.getAlphaColor(40)
    waitViewController?.indicatorColor = Config.Colors.tint
    waitViewController?.alertBackgroundColor = Config.Colors.backgroundLight
    waitViewController?.textColor = Config.Colors.blue
    waitViewController?.alertTitle = title
    waitViewController?.alertSize = CGSize(width: 100, height: 100)
    waitViewController?.show()
}
public func hideWaitView() {
    waitViewController?.hide()
}

public func showModalCardView(content: UIView?) {
    let _vc = UIX3ModalCardViewController()
    _vc.show(content, atState: .normal)
}
