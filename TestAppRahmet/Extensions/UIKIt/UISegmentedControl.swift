import UIKit

extension UISegmentedControl {
    
    func change(cornerRadius: CGFloat) {
        superview?.clipsToBounds = true
        superview?.layer.cornerRadius = cornerRadius
        superview?.layer.borderWidth = 1
        superview?.layer.borderColor = #colorLiteral(red: 0.4039215686, green: 0.2274509804, blue: 0.7176470588, alpha: 1)
    }
    
}
