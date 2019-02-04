import RxSwift

enum Period: Int {
    
    case week
    case month
    case year
    
}

class PricesViewModel {

    private let disposeBag = DisposeBag()
    private let bitcoinService = BitcoinService()
    
    var bitcoinPrice: Double = 0.0
    
    var bpi = [String: Double]()
    
    let currencyCodes: [CurrencyCode] = [.usd, .eur, .kzt]
    
    let periods: [Period] = [.week, .month, .year]
    
    var startDate = Date()
    
    func getBitcoinCurrentPrice(for currencyCode: String) -> Observable<BitcoinPriceWrapper> {
        return bitcoinService.getCurrentPrice(currency: currencyCode)
    }
    
    func getHistory(for currencyCode: String, startDate: Date, endDate: Date) -> Observable<BitcoinHistory> {
        return bitcoinService.getHistory(currencyCode: currencyCode, startDate: startDate, endDate: endDate)
    }
    
    private func getDates(between startDate: Date, and endDate: Date) -> [Date] {
        var dates = [Date]()
        var dateCounter = startDate
        while dateCounter <= endDate {
            if let date = Calendar.current.date(byAdding: .day, value: 1, to: dateCounter) {
                dates.append(date)
                dateCounter = date
            }
        }
        return dates
    }

    func getStartDate(for period: Period) -> Date {
        switch period {
        case .week:
            return Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        case .month:
            return Calendar.current.date(byAdding: .day, value: -31, to: Date()) ?? Date()
        case .year:
            return Calendar.current.date(byAdding: .day, value: -365, to: Date()) ?? Date()
        }
    }
    
    func getLabels(period: Period) -> [String] {
        switch period {
        case .week:
            let dates = getDates(between: getStartDate(for: period), and: Date())
            return dates.map { $0.dayOfTheWeek() }
        case .month:
            return ["Неделя 1", "Неделя 2", "Неделя 3", "Неделя 4"]
        case .year:
            return Calendar.current.shortMonthSymbols
        }
       
    }
    
    func getValues(for period: Period) -> [Double] {
        var values = [Double]()
        let dates = getDates(between: getStartDate(for: period), and: Date())
        let keys = dates.map { date in
            date.toString(with: "yyyy-MM-dd")
        }
        
        switch period {
        case .week:
            for key in keys {
                values.append(bpi[key] ?? 0.0)
            }
        case .month:
            return getAverageValues(for: .month, keys: keys)
        case .year:
            return getAverageValues(for: .year, keys: keys)
        }
       
        return values
    }
    
    private func getAverageValues(for period: Period, keys: [String]) -> [Double] {
        var values = [Double]()
        var sum = 0.0
        var counter = 0
        for key in keys {
            sum += bpi[key] ?? 0.0
            if counter % (period == .month ? 7 : 30) == 0 {
                values.append(sum / (period == .month ? 7 : 30))
                sum = 0
            }
            counter += 1
        }
        return values
    }
    
}
