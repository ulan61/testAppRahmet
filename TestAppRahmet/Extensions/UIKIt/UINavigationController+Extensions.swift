import UIKit

extension UINavigationController {
    
    func changeNavBarColor(to color: UIColor, shouldShowShadow: Bool) {
        navigationBar.barTintColor = color
        navigationBar.shadowImage = shouldShowShadow ? nil : UIImage()
    }
    
    func changeTintColor(to color: UIColor) {
        navigationBar.tintColor = color
    }
    
}

class NavigationViewControllerWithoutBackTitle: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}
