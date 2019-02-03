import RxSwift
import RxCocoa

final class TransactionCellViewModel {
    
    let title: String
    let shortTitle: String
    let amount: String
    let date: String
    let time: String
    
    init(title: String, shortTitle: String, amount: String, date: String, time: String) {
        self.title = title
        self.shortTitle = shortTitle
        self.amount = amount
        self.date = date
        self.time = time
    }

}
