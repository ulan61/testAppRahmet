import RxSwift

enum TabBarItem: Int {
    
    case prices
    case transactions
    case converter
    
    var title: String {
        switch self {
        case .prices:
            return L10n.prices
        case .transactions:
            return L10n.transactions
        case .converter:
            return L10n.converter
        }
    }
    
    var image: UIImage {
        switch self {
        case .prices:
            return #imageLiteral(resourceName: "prices")
        case .transactions:
            return #imageLiteral(resourceName: "transactions")
        case .converter:
            return #imageLiteral(resourceName: "converter")
        }
    }
    
    var tabbarItem: UITabBarItem {
        return UITabBarItem(title: title, image: image, selectedImage: nil)
    }
    
    var viewController: UIViewController {
        let viewController: UIViewController
        switch self {
        case .prices:
            viewController = NavigationService.createPricesViewController().embebbedInNavigationController()
        case .transactions:
            viewController = NavigationService.createTransactionsViewController().embebbedInNavigationController()
        case .converter:
            viewController = NavigationService.createConverterViewController().embebbedInNavigationController()
        }
        viewController.tabBarItem = tabbarItem
        viewController.view.backgroundColor = .white
        return viewController
    }
    
}

class TabbarViewModel {

    private let disposeBag = DisposeBag()
    
    let tabbarItems: [TabBarItem] = [.prices, .transactions, .converter]

}
