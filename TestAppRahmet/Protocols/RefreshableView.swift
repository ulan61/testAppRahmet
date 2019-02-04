import UIKit

@objc protocol RefreshableView {
    
    var scrollView: UIScrollView { get }
    
    var refreshControl: UIRefreshControl? { get set }
    
    @objc func refresh()
    
}

extension RefreshableView where Self: UIViewController {
    
    func initialRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    func endRefresh() {
        refreshControl?.endRefreshing()
    }
    
}
