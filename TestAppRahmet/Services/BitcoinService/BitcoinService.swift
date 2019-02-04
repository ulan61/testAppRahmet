import RxSwift

class BitcoinService {
    
    private let transport = Transport()
    
    func getCurrentPrice(currency: String) -> Observable<BitcoinPriceWrapper> {
        return transport.makeRequestModel(request: BitcoinRouter.getCurrentPrice(currency: currency))
    }
    
    func getHistory(currencyCode: String, startDate: Date, endDate: Date) -> Observable<BitcoinHistory> {
        return transport.makeRequestModel(request: BitcoinRouter.getHistory(currencyCode: currencyCode, startDate: startDate, endDate: endDate))
    }
    
}
