import RxSwift
import RxCocoa
import Alamofire
import ObjectMapper
import UIKit

class Transport {
    
    private let requestCount = Variable<Int>(0)
    private let disposeBag = DisposeBag()
    private let urlSessionConfiguration: URLSessionConfiguration
    private let serializer = Serializer()
    
    private lazy var sessionManager: SessionManager = {
        SessionManager(configuration: self.urlSessionConfiguration)
    }()
    
    init(urlSessionConfiguration: URLSessionConfiguration = .default) {
        self.urlSessionConfiguration = urlSessionConfiguration
        bindNetworkActivity()
    }
    
    @discardableResult
    func makeRequestModel<T: BaseMappable>(request: URLRequestConvertible) -> Observable<T> {
        return sessionManager.request(request)
            .rx
            .responseJSON()
            .map(serializer.mapModel)
            .counterTracking(with: self)
    }
    
    func makeSimpleArrayRequest<T: BaseMappable>(request: URLRequestConvertible) -> Observable<[T]> {
        return sessionManager.request(request)
            .rx
            .responseJSON()
            .map(serializer.mapArrayWithForceCast)
            .counterTracking(with: self)
    }
    
    fileprivate func increaseRequestCounter() {
        requestCount.value += 1
    }
    
    fileprivate func decreaseRequestCounter() {
        requestCount.value -= 1
    }
    
    private func bindNetworkActivity() {
        requestCount
            .asObservable()
            .map { $0 != 0 }
            .observeOn(MainScheduler.instance)
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
    }
    
    deinit {
        sessionManager.session.invalidateAndCancel()
    }
    
}

fileprivate extension Observable {
    
    func counterTracking(with networkService: Transport) -> Observable<Observable.E> {
        return `do`(onSubscribe: {
            networkService.increaseRequestCounter()
        }, onDispose: {
            networkService.decreaseRequestCounter()
        })
    }
    
}
