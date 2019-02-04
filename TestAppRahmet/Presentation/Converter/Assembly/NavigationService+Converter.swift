import UIKit

extension NavigationService {

    static func createConverterViewController() -> ConverterViewController {
        let viewController: ConverterViewController = UIStoryboard(storyboard: .converter).instantiateViewController()
        let assembly = ConverterAssembly()
        assembly.configure(input: viewController)
        return viewController
    }

}
