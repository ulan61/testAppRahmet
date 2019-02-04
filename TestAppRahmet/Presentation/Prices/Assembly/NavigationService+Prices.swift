import UIKit

extension NavigationService {

    static func createPricesViewController() -> PricesViewController {
        let viewController: PricesViewController = UIStoryboard(storyboard: .prices).instantiateViewController()
        let assembly = PricesAssembly()
        assembly.configure(input: viewController)
        return viewController
    }

}
