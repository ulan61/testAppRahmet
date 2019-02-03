import UIKit

class NavigationService {
    
    static var window: UIWindow? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if appDelegate?.window == nil {
            appDelegate?.window = UIWindow(frame: UIScreen.main.bounds)
            appDelegate?.window?.makeKeyAndVisible()
        }
        return appDelegate?.window
    }
    
    static func prepareRootController() {
        let main = NavigationService.createTabbarViewController()
        window?.changeRootViewController(to: main)
    }
    
}
