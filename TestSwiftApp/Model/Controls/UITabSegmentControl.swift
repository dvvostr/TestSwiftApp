import UIKit

public class UITabSegmentControl: UISegmentedControl {
    override init(items: [Any]?) {
        super.init(items: items)
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    public var font: UIFont? {
        didSet {
            invalidate()
        }
    }
    public override var tintColor: UIColor! {
        didSet {
            invalidate()
        }
    }
    public var items: [String] = [] {
        didSet {
            self.removeAllSegments()
            for (_i, _item) in self.items.enumerated() {
                self.insertSegment(withTitle: _item, at: _i, animated: false)
            }
            if self.numberOfSegments ?? 0 > 0 {
                self.selectedSegmentIndex = 0
                self.sendActions(for: .valueChanged)
            }
        }
    }
    // Used for the selected label
    public override var selectedSegmentTintColor: UIColor? {
        didSet {
            invalidate()
        }
    }
    private lazy var underline: UIView = {
        let _view = UIView()
        _view.backgroundColor = Config.Colors.orange
        return _view
    }()

    private func setup() {
        backgroundColor = .clear

        // Use a clear image for the background and the dividers
        let _clearImage = UIImage(color: .clear, size: CGSize(width: 1, height: 32))
        setBackgroundImage(_clearImage, for: .normal, barMetrics: .default)
        setDividerImage(_clearImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        self.addSubview(underline)
        
        invalidate()
    }
    private func invalidate() {
        setTitleTextAttributes([.foregroundColor: tintColor!, NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 16, weight: .regular)], for: .normal)
        setTitleTextAttributes([.foregroundColor: selectedSegmentTintColor ?? tintColor!, NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 16, weight: .regular)], for: .selected)

    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0
        var _rect = CGRect.zero
        if self.numberOfSegments > 0 {
            let _width = self.bounds.size.width / CGFloat(self.numberOfSegments)
            _rect = CGRect(
                x: CGFloat(selectedSegmentIndex * Int(_width)),
                y: self.bounds.size.height - 3.0,
                width: _width,
                height: 4
            )
        }
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            self.underline.frame = _rect
        })
    }
    func underlinePosition(){
        let xPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            self.underline.frame.origin.x = xPosition
        })
    }
}
