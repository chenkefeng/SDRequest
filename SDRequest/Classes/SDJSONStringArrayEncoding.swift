//
//  JSONStringArrayEncoding.swift
//  Pods
//
//  Created by 陈克锋 on 2017/8/1.
//
//

import UIKit
import Moya
import Alamofire

public class SDJSONStringArrayEncoding: ParameterEncoding {

    private let array: [String]
    
    public init(array: [String]) {
        self.array = array
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: [String:Any]?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        let data = try JSONSerialization.data(withJSONObject: array, options: [])
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = data
        
        return urlRequest
    }
    
}
