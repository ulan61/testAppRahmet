import UIKit
import RxSwift
import RxCocoa

class TransactionViewController: UIViewController {

    var viewModel: TransactionViewModel!
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var sumLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }
    
    private func populateLabels(with price: BitcoinPrice?) {
        guard let price = price else {
            return
        }
        idLabel.text = viewModel.transaction.tid
        timeLabel.text = viewModel.transaction.date.timeIn24HourFormat()
        dateLabel.text = viewModel.transaction.date.toString()
        if let amount = Double(viewModel.transaction.amount) {
            sumLabel.text = "$ \((amount * price.rateFloat).rounded(to: 2))"
        }
        rateLabel.text = "$ " + price.rate
    }
    
    private func getCurrentPrice() {
        activityIndicator.startAnimating()
        viewModel.getCurrentPrice()
            .subscribe(onNext: {[weak self] wrapper in
                self?.populateLabels(with: wrapper.getBitcoinPrice(for: "USD"))
                }, onError: { [weak self] error in
                    self?.showAlert(message: error.localizedDescription) { _ in
                        self?.activityIndicator.stopAnimating()
                    }
                }, onCompleted: { [weak self] in
                    self?.activityIndicator.stopAnimating()
            }).disposed(by: disposeBag)
    }

}

extension TransactionViewController: ConfigurableController {

    func bindViews() {
        getCurrentPrice()
    }

    func setAppearance() {

    }

    func addViews() {

    }

    func configureBarButtons() {

    }

    func localize() {
        navigationItem.title = L10n.aboutTransaction
    }

}
