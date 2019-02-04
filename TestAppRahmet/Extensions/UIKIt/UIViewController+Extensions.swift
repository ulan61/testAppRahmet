import UIKit

extension UIViewController: StoryboardIdentifierProtocol {
    
    //swiftlint:disable return_arrow_whitespace
    func showAlert(message: String, completion: @escaping (_ action: UIAlertAction)->Void = { _ in }) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0, green: 0.6588235294, blue: 0.1764705882, alpha: 1)
        alert.addAction(UIAlertAction(title: L10n.okTitle, style: .default, handler: { action in
            completion(action)
        }))
        present(alert, animated: true, completion: nil)
    }
    //swiftlint:enable return_arrow_whitespace
    
    func embebbedInNavigationController() -> UINavigationController {
        return NavigationViewControllerWithoutBackTitle(rootViewController: self)
    }

}
