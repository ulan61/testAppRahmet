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
    
    private lazy var transactionSection = TableSection(rows: [])

    @IBAction private func valueChanged(_ sender: UISegmentedControl) {
        clearTransactionSection()
        populateTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }
    
    private func configureSegmentsBackgroundAppearance() {
        sementedControlBackground.clipsToBounds = true
        sementedControlBackground.layer.cornerRadius = 15
        sementedControlBackground.layer.borderWidth = 1
        sementedControlBackground.layer.borderColor = #colorLiteral(red: 0.4039215686, green: 0.2274509804, blue: 0.7176470588, alpha: 1)
    }
    
    private func initialTableView() {
        tableDirector += transactionSection
    }
    
    private func populateTableView() {
        let transactionsViewModels = viewModel.getTransactionViewModels(by: "\(segmentedControl.selectedSegmentIndex)")
        let rows = transactionsViewModels.map { TableRow<TransactionCell>(item: $0) }
        transactionSection.append(rows: rows)
        tableDirector.reload()
    }
    
    private func getTransactions() {
        activityIndicator.startAnimating()
        viewModel.getTransactions().subscribe(onNext: { [weak self] transactions in
            self?.viewModel.transactions = transactions
        }, onError: { error in
            print(error)
        }, onCompleted: { [weak self] in
            self?.populateTableView()
            self?.activityIndicator.stopAnimating()
        }).disposed(by: disposeBag)
    }
    
    private func configureRefreshBarButton() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
        barButtonItem.tintColor = #colorLiteral(red: 0.4039215686, green: 0.2274509804, blue: 0.7176470588, alpha: 1)
        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc private func reloadData() {
        clearTransactionSection()
        getTransactions()
    }
    
    private func clearTransactionSection() {
        transactionSection.clear()
        tableDirector.reload()
    }
    
}

extension TransactionsViewController: ConfigurableController {

    func bindViews() {
        getTransactions()
    }

    func setAppearance() {
        navigationController?.changeNavBarColor(to: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), shouldShowShadow: true)
        configureSegmentsBackgroundAppearance()
        tableView.hideUnusedCells()
    }

    func addViews() {
        initialTableView()
    }

    func configureBarButtons() {
        configureRefreshBarButton()
    }

    func localize() {
        navigationItem.title = L10n.transactions
    }

}
