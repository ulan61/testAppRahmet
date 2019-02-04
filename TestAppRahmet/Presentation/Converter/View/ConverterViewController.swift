import UIKit
import RxSwift
import RxCocoa

class ConverterViewController: UIViewController {

    var viewModel: ConverterViewModel!
    
    private let disposeBag = DisposeBag()
    
    private var currencyCode: String {
        return viewModel.currencyCodes[segmentedControl.selectedSegmentIndex].code
    }
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var activeTextField: UITextField!
    @IBOutlet private weak var disabledTextField: UITextField!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction private func valueChanged(_ sender: UISegmentedControl) {
        clearInputs()
        configureTextFields()
        getCurrentBitcoinPrice(for: currencyCode)
    }
    
    @IBAction private func swapTextFields(_ sender: UIButton) {
        viewModel.isBitcoinField.toggle()
        configureTextFields()
        let tempText = activeTextField.text
        activeTextField.text = disabledTextField.text
        disabledTextField.text = tempText
    }
    
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }
    
    private func configureTextFields() {
        activeTextField.leftViewMode = .always
        disabledTextField.leftViewMode = .always
        if viewModel.isBitcoinField {
            activeTextField.leftView = getLeftLabel(with: "BTC")
            disabledTextField.leftView = getLeftLabel(with: currencyCode)
        } else {
            activeTextField.leftView = getLeftLabel(with: currencyCode)
            disabledTextField.leftView = getLeftLabel(with: "BTC")
        }
    }
    
    private func clearInputs() {
        activeTextField.text = ""
        disabledTextField.text = ""
        
    }
    
    private func getCurrentBitcoinPrice(for currencyCode: String) {
        activityIndicator.startAnimating()
        viewModel.getBitcoinCurrentPrice(for: currencyCode)
            .subscribe(onNext: {[weak self] wrapper in
                self?.viewModel.bitcoinPrice = wrapper.getBitcoinPrice(for: currencyCode)?.rateFloat ?? 0
            }, onError: { [weak self] error in
                self?.showAlert(message: error.localizedDescription) { _ in
                    self?.activityIndicator.stopAnimating()
                }
            }, onCompleted: { [weak self] in
                self?.activityIndicator.stopAnimating()
            }).disposed(by: disposeBag)
    }
    
    func getLeftLabel(with title: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: activeTextField.bounds.height, height: activeTextField.bounds.height))
        label.text = title
        label.textColor = #colorLiteral(red: 0.5411764706, green: 0.5411764706, blue: 0.5607843137, alpha: 1)
        return label
    }
    
    func setupActiveTextFieldObserver() {
        activeTextField.rx.text
            .subscribe(onNext: { [weak self] text in
            guard let sSelf = self, let text = text else {
                return
            }
            sSelf.disabledTextField.text = "\(sSelf.viewModel.calculatedValue(for: text))"
            if text.isEmpty {
                sSelf.disabledTextField.text = ""
            }
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)
    }

}

extension ConverterViewController: ConfigurableController {

    func bindViews() {
        getCurrentBitcoinPrice(for: currencyCode)
        setupActiveTextFieldObserver()
    }

    func setAppearance() {
        segmentedControl.change(cornerRadius: 15)
        configureTextFields()
    }

    func addViews() {
        
    }

    func configureBarButtons() {

    }

    func localize() {
        navigationItem.title = L10n.converter
    }

}
