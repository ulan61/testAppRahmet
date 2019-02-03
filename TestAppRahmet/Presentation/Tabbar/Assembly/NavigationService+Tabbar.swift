import UIKit

extension NavigationService {

    static func createTabbarViewController() -> TabbarViewController {
        let viewController: TabbarViewController = UIStoryboard(storyboard: .tabbar).instantiateViewController()
        let assembly = TabbarAssembly()
        assembly.configure(input: viewController)
        return viewController
    }

}
