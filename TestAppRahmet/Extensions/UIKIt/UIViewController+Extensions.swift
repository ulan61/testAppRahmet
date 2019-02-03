import UIKit

extension UIViewController: StoryboardIdentifierProtocol {
    
    func embebbedInNavigationController() -> UINavigationController {
        return NavigationViewControllerWithoutBackTitle(rootViewController: self)
    }

}
