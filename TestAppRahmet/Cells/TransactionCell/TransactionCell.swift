import UIKit
import TableKit
import RxSwift
import RxCocoa

final class TransactionCell: UITableViewCell, ConfigurableCell {

    fileprivate var disposeBag = DisposeBag()
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var shortTitleLabel: UILabel!
    @IBOutlet private var amountLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    
    static var defaultHeight: CGFloat? {
        return 60.0
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
    }

    func configure(with viewModel: TransactionCellViewModel) {
        titleLabel.text = viewModel.title
        shortTitleLabel.text = viewModel.shortTitle
        amountLabel.text = viewModel.amount
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
    }

}
