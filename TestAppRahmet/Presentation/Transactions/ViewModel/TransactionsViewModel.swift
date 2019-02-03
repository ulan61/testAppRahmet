import RxSwift

class TransactionsViewModel {

    private let disposeBag = DisposeBag()
    private let service = TransactionService()
    private let maxTransactionsCount = 500
    
    var transactions = [Transaction]()
    
    func getTransactionViewModels(by type: String) -> [TransactionCellViewModel] {
        let filteredTransactions = transactions.prefix(maxTransactionsCount).filter {
            $0.type == type
        }
        return filteredTransactions.map {
            TransactionCellViewModel(title: "Bitcoin Cash",
                                     shortTitle: "BCH",
                                     amount: $0.amount,
                                     date: $0.date.toString(),
                                     time: $0.date.timeIn24HourFormat())
        }
    }
    
    func getTransactions() -> Observable<[Transaction]> {
        return service.getTransactions()
    }

}
