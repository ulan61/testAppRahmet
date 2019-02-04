import UIKit
import RxSwift
import RxCocoa
import TableKit

class TransactionsViewController: UIViewController {
    
    private let disposeBag = DisposeBag()

    var viewModel: TransactionsViewModel!
    
    @IBOutlet private weak var tableView: UITableView!
    private lazy var tableDirector = TableDirector(tableView: tableView)
    
    @IBOutlet private weak var sementedControlBackground: UIView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var refreshControl: UIRefreshControl?
    
    private lazy var transactionSection = TableSection(rows: [])
    
    private lazy var showTransactionAction = TableRowAction<TransactionCell>(.click) { [weak self] options in
        self?.showTransaction(at: options.indexPath.row)
    }

    @IBAction private func valueChanged(_ sender: UISegmentedControl) {
        clearTransactionSection()
        populateTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }
    
    private func configureSegmentsBackgroundAppearance() {
        segmentedControl.change(cornerRadius: 15)
    }
    
    private func initialTableView() {
        tableDirector += transactionSection
    }
    
    private func populateTableView() {
        let transactionsViewModels = viewModel.getTransactionViewModels(by: "\(segmentedControl.selectedSegmentIndex)")
        let rows = transactionsViewModels.map {
            TableRow<TransactionCell>(item: $0,
                                      actions: [showTransactionAction])
            
        }
        transactionSection.append(rows: rows)
        tableDirector.reload()
    }
    
    private func getTransactions(isReloading: Bool = false) {
        if !isReloading {
            activityIndicator.startAnimating()
        }
        viewModel.getTransactions().subscribe(onNext: { [weak self] transactions in
            self?.viewModel.transactions = transactions
        }, onError: { [weak self] error in
            self?.showAlert(message: error.localizedDescription) { _ in
                self?.endLoading()
            }
        }, onCompleted: { [weak self] in
            self?.populateTableView()
            self?.endLoading()
        }).disposed(by: disposeBag)
    }
    
    private func endLoading() {
        activityIndicator.stopAnimating()
        refreshControl?.endRefreshing()
    }
    
    private func clearTransactionSection() {
        transactionSection.clear()
        tableDirector.reload()
    }
    
    private func showTransaction(at index: Int) {
        let transaction = NavigationService.createTransactionViewController(with: viewModel.transactions[index])
        navigationController?.pushViewController(transaction, animated: true)
    }
    
}

extension TransactionsViewController: ConfigurableController {

    func bindViews() {
        getTransactions()
    }

    func setAppearance() {
        navigationController?.changeNavBarColor(to: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), shouldShowShadow: true)
        navigationController?.changeTintColor(to: #colorLiteral(red: 0.4039215686, green: 0.2274509804, blue: 0.7176470588, alpha: 1))
        configureSegmentsBackgroundAppearance()
        tableView.hideUnusedCells()
    }

    func addViews() {
        initialTableView()
        initialRefreshControl()
    }

    func configureBarButtons() {

    }

    func localize() {
        navigationItem.title = L10n.transactions
    }

}

extension TransactionsViewController: RefreshableView {
    
    var scrollView: UIScrollView {
        return tableView
    }
    
    func refresh() {
        getTransactions(isReloading: true)
    }
    
}
