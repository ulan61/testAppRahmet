import UIKit
import RxSwift
import RxCocoa

class TabbarViewController: UITabBarController {

    var viewModel: TabbarViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }
    
    private func configureTabbarAppearance() {
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1)
        tabBar.tintColor = #colorLiteral(red: 0.4039215686, green: 0.2274509804, blue: 0.7176470588, alpha: 1)
        tabBar.barTintColor = .white
    }

}

extension TabbarViewController: ConfigurableController {

    func bindViews() {
        let viewControllers = viewModel.tabbarItems.map { $0.viewController }
        setViewControllers(viewControllers, animated: false)
    }

    func setAppearance() {
        configureTabbarAppearance()
    }

    func addViews() {

    }

    func configureBarButtons() {

    }

    func localize() {

    }

}
