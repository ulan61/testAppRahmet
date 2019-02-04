import RxSwift

enum CurrencyCode: Int {
    
    case usd
    case eur
    case kzt
    
    var code: String {
        switch self {
        case .usd:
            return "USD"
        case .eur:
            return "EUR"
        case .kzt:
            return "KZT"
        }
    }
    
}

class ConverterViewModel {

    private let disposeBag = DisposeBag()
    
    private let bitcoinService = BitcoinService()
    
    var bitcoinPrice: Double = 0.0

    var currencyCodes: [CurrencyCode] = [.usd, .eur, .kzt]
    
    var isBitcoinField = false
    
    func getBitcoinCurrentPrice(for currencyCode: String) -> Observable<BitcoinPriceWrapper> {
        return bitcoinService.getCurrentPrice(currency: currencyCode)
    }
    
    func calculatedValue(for introducedValue: String) -> Double {
        guard let introducedValue = Double(introducedValue) else {
            return 0
        }
        if isBitcoinField {
            return introducedValue * bitcoinPrice
        }
        return introducedValue / bitcoinPrice
    }
    
}
