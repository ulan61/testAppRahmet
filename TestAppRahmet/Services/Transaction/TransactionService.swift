import RxSwift

class TransactionService {
    
    private let transport = Transport()
    
    func getTransactions() -> Observable<[Transaction]> {
        return transport.makeSimpleArrayRequest(request: TransactionRouter.getTransactions)
    }
    
}
