import Alamofire

let bitcoinUrl = "https://api.coindesk.com/v1/bpi/historical/close.json"
let transactionsUrl = "https://www.bitstamp.net"

protocol BaseRouter: URLRequestConvertible {
    
    var baseApiUrl: String { get }
    
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    
}

extension BaseRouter {

    var parameters: Parameters? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseApiUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        if method == .post {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: self.parameters)
        } else {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: self.parameters)
        }
        
        return urlRequest
    }
    
}
