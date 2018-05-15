//
//  Requestable.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/8/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import ReSwift
import ObjectMapper
import Alamofire
import PromiseKit

protocol Requestable: Action, URLRequestConvertible {
    associatedtype T
    
    var basePath: String { get }
    
    var endPoint: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var param: Parameters? { get }
    
    var additionalHeader: HeaderParameter? { get }
    
    var parameterEncoding: ParameterEncoding { get }
    
    func toPromise() -> Promise<T>
    
    func decode(data: Any) -> T
    
    init(param: Parameters?)
}

extension Requestable {
    func asURLRequest() throws -> URLRequest {
        return self.buildUrlRequest()
    }
}

extension Requestable {
    
    typealias Parameters = [String: Any]
    typealias HeaderParameter = [String: String]
    typealias JSONDictionary = [String: Any]
    
    var basePath: String {
        get { return Constants.App.BaseURL }
    }
    
    var param: Parameters? {
        get { return nil }
    }
    
    var additionalHeader: HeaderParameter? {
        get { return nil }
    }
    
    var defaultHeader: HeaderParameter {
        get { return ["Accept": "application/json"] }
    }
    
    var urlPath: String {
        return basePath + endPoint
    }
    
    var url: URL? {
        return URL(string: urlPath).addApiKey()
    }
    
    var parameterEncoding: ParameterEncoding {
        get { return JSONEncoding.default }
    }
    
    func toPromise() -> Promise<T> {
        return Promise { fullfill, reject in
            
            guard let urlReq = try? self.asURLRequest() else {
                reject(NSError.unknowError())
                return
            }
            
            Alamofire.request(urlReq)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                if let error = response.result.error {
                    reject(error as NSError)
                    return
                }
                
                guard let data = response.result.value else {
                    reject(NSError.jsonMapperError())
                    return
                }
                
                let result = self.decode(data: data)
                
                fullfill(result)
            })
        }
    }
    
    func buildUrlRequest() -> URLRequest {
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = self.httpMethod.rawValue
        urlRequest.timeoutInterval = TimeInterval(10 * 1000)
        var request = try! self.parameterEncoding.encode(urlRequest, with: self.param)
        if let additinalHeaders = self.additionalHeader {
            for (key, value) in additinalHeaders {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
}
