//
//  SDTargetType.swift
//  Pods
//
//  Created by 陈克锋 on 2017/8/1.
//
//

import UIKit
import Moya
import Alamofire

public typealias HttpMethod = Moya.Method

/// Choice of parameter encoding.
public typealias ParameterEncoding = Moya.ParameterEncoding
public typealias JSONEncoding = Moya.JSONEncoding
public typealias URLEncoding = Moya.URLEncoding
public typealias PropertyListEncoding = Moya.PropertyListEncoding

/// Multipart form
public typealias RequestMultipartFormData = Moya.MultipartFormData

/// Multipart form data encoding result.
public typealias MultipartFormDataEncodingResult = Manager.MultipartFormDataEncodingResult
public typealias DownloadDestination = Moya.DownloadDestination
public typealias DownloadOptions = Alamofire.DownloadRequest.DownloadOptions
public typealias DownloadRequest = Alamofire.DownloadRequest


/// 公共参数
private var sd_commonParamters: [String: Any] = [:]
/// 公共头信息
private var sd_commonHeaders: [String: String] = [:]

public protocol SDRequestable: TargetType {
    
    /// 公共参数
    var commonParamters: [String: Any]? {get}
    
    /// 公共请求头信息
    var commonHeaders: [String:String]? {get}
    
    /// 每个请求的头信息
    var headers: [String:String]? {get}
    
    var method: HttpMethod { get }
}

public extension SDRequestable {
    
    var commonParamters: [String: Any]? {
        return sd_commonParamters
    }
    
    var commonHeaders: [String:String]? {
        return sd_commonHeaders
    }
    
    var headers: [String:String]? {
        return nil
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var task: Task {
        return .request
    }
    
    public func setCommonHeaders(headers: [String:String]?) {
        if headers == nil {
            sd_commonHeaders = [:]
        } else {
            for (key, value) in headers! {
                sd_commonHeaders[key] = value
            }
        }
    }
    
    public func setCommonParamters(paramters: [String: Any]?) {
        if paramters == nil {
            sd_commonParamters = [:]
        } else {
            for (key, value) in paramters! {
                sd_commonParamters[key] = value
            }
        }
        
    }

}

