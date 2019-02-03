import UIKit

protocol ConfigurableController {
    
    func bindViews()
    
    func addViews()
    
    func setAppearance()
    
    func configureBarButtons()
    
    func localize()
    
    func initialLoadView()
    
}

extension ConfigurableController where Self: UIViewController {
    
    func bindViews() {
        
    }
    
    func addViews() {
        
    }
    
    func setAppearance() {
        
    }
    
    func configureBarButtons() {
        
    }
    
    func localize() {
        
    }
    
    func initialLoadView() {
        addViews()
        setAppearance()
        configureBarButtons()
        localize()
        bindViews()
    }
    
}
