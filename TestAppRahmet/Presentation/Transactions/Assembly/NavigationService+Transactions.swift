import UIKit

extension NavigationService {

    static func createTransactionsViewController() -> TransactionsViewController {
        let viewController: TransactionsViewController = UIStoryboard(storyboard: .transactions).instantiateViewController()
        let assembly = TransactionsAssembly()
        assembly.configure(input: viewController)
        return viewController
    }

}
