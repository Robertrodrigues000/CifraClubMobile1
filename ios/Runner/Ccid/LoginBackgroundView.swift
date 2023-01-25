import Foundation
import UIKit

class LoginBackgroundView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var patternView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        Bundle.main.loadNibNamed("LoginBackgroundView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = UIScreen.main.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
