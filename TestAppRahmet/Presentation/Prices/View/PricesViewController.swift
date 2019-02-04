import UIKit
import RxSwift
import RxCocoa
import Charts

class PricesViewController: UIViewController {

    var viewModel: PricesViewModel!
    
    private let disposeBag = DisposeBag()
    
    private var currentCurrencyCode: String {
        return viewModel.currencyCodes[segmentedControl.selectedSegmentIndex].code
    }
    
    private var currentPeriod: Period {
        return viewModel.periods[periodSegmentedControl.selectedSegmentIndex]
    }
    
    var labels: [String] {
        return viewModel.getLabels(period: currentPeriod)
    }
    
    var values: [Double] {
        return viewModel.getValues(for: currentPeriod)
    }
    
    @IBOutlet private weak var lineChartView: LineChartView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var periodSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var rateLabel: UILabel!
    
    @IBAction private func valueChanged(_ sender: UISegmentedControl) {
        getCurrentBitcoinPrice(for: currentCurrencyCode)
        getHistory(for: currentPeriod)
    }
    
    @IBAction private func periodValueChanged(_ sender: UISegmentedControl) {
        getHistory(for: currentPeriod)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }
    
    func setChartData(count: Int) {
        let values = (0..<count).map { index -> ChartDataEntry in
            ChartDataEntry(x: Double(index), y: self.values[index])
        }
        
        let set1 = LineChartDataSet(values: values, label: "")

    
        let data = LineChartData(dataSets: [set1])
       
        configureLineChartViewAppearance()
        
        lineChartView.data = data
    }
    
    private func configureLineChartViewAppearance() {
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.avoidFirstLastClippingEnabled = true
        lineChartView.rightAxis.drawAxisLineEnabled = false
        lineChartView.rightAxis.drawLabelsEnabled = false
        lineChartView.rightAxis.gridColor = .clear
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.leftAxis.gridColor = .clear
        lineChartView.leftAxis.drawLabelsEnabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.legend.enabled = false
    }
    
    private func getCurrentBitcoinPrice(for currencyCode: String) {
        activityIndicator.startAnimating()
        viewModel.getBitcoinCurrentPrice(for: currencyCode)
            .subscribe(onNext: {[weak self] wrapper in
                self?.viewModel.bitcoinPrice = wrapper.getBitcoinPrice(for: currencyCode)?.rateFloat ?? 0
                self?.rateLabel.text = "\(wrapper.getBitcoinPrice(for: currencyCode)?.rateFloat ?? 0)"
                }, onError: { [weak self] error in
                    self?.showAlert(message: error.localizedDescription) { _ in
                        self?.activityIndicator.stopAnimating()
                    }
                }, onCompleted: { [weak self] in
                    self?.activityIndicator.stopAnimating()
            }).disposed(by: disposeBag)
    }
    
    private func getHistory(for period: Period) {
        self.activityIndicator.startAnimating()
        viewModel.getHistory(for: currentCurrencyCode, startDate: viewModel.getStartDate(for: period), endDate: Date())
            .subscribe(onNext: { [weak self] history in
                self?.viewModel.bpi = history.bpi
            }, onError: { [weak self] error in
                self?.showAlert(message: error.localizedDescription) { _ in
                    self?.activityIndicator.stopAnimating()
                }
            }, onCompleted: { [weak self] in
                guard let sSelf = self else {
                    return
                }
                self?.activityIndicator.stopAnimating()
                sSelf.setChartData(count: sSelf.labels.count)
            }).disposed(by: disposeBag)
    }
    
}

extension PricesViewController: ConfigurableController {

    func bindViews() {
        getCurrentBitcoinPrice(for: currentCurrencyCode)
        getHistory(for: currentPeriod)
    }

    func setAppearance() {
        segmentedControl.change(cornerRadius: 15)
        periodSegmentedControl.change(cornerRadius: 15)
    }

    func addViews() {
        
    }

    func configureBarButtons() {

    }

    func localize() {

    }

}
