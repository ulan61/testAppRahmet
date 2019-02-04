import UIKit

extension NavigationService {

    static func createTransactionViewController(with transaction: Transaction) -> TransactionViewController {
        let viewController: TransactionViewController = UIStoryboard(storyboard: .transaction).instantiateViewController()
        let assembly = TransactionAssembly()
        assembly.configure(input: viewController, with: transaction)
        return viewController
    }

}
