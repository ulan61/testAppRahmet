import RxSwift

class TransactionViewModel {

    private let disposeBag = DisposeBag()
    
    private let bitcoinService = BitcoinService()
        
    let transaction: Transaction
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    func getCurrentPrice() -> Observable<BitcoinPriceWrapper> {
        return bitcoinService.getCurrentPrice(currency: "usd")
    }

}
