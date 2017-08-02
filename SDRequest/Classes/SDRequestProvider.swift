//
//  SDRequestProvider.swift
//  Pods
//
//  Created by 陈克锋 on 2017/7/31.
//
//

import UIKit
import Moya
import Alamofire

public typealias Manager = Moya.Manager
public typealias NetworkLoggerPlugin = Moya.NetworkLoggerPlugin
public typealias Task = Moya.Task
public typealias UploadType = Moya.UploadType
public typealias DownloadType = Moya.DownloadType
public typealias MultipartFormData = Moya.MultipartFormData
public typealias ProgressResponse = Moya.ProgressResponse

public extension SDRequestProvider {

    public class func sdEndpointMapping(for target: Target) -> Endpoint<Target> {
        
        let reqInfo = requestInfo(for: target)
        
        return Endpoint(url: reqInfo.url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: reqInfo.parameters, parameterEncoding: target.parameterEncoding, httpHeaderFields: reqInfo.headers)
    }
    
    private static func requestInfo(for target: Target) -> (url: String, parameters: [String:Any]?, headers: [String:String]?) {
        
        /// 请求参数信息
        var paramters = target.commonParamters ?? [:]
        for (key, value) in target.parameters ?? [:] {
            paramters[key] = value
        }
        
        /// 请求头信息
        var headers = target.commonHeaders ?? [:]
        for (key, value) in target.headers ?? [:] {
            headers[key] = value
        }
        
        /// 请求地址
        var baseURL = target.baseURL
        baseURL.appendPathComponent(target.path)
        
        return (baseURL.absoluteString, paramters, headers)
    }
    
}

open class SDRequestProvider<Target>: RxMoyaProvider<Target> where Target: SDRequestable {

    override public init(endpointClosure: @escaping EndpointClosure = SDRequestProvider.sdEndpointMapping,
                         requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
                         stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
                         manager: Manager = RxMoyaProvider<Target>.defaultAlamofireManager(),
                         plugins: [PluginType] = [],
                         trackInflights: Bool = false) {
        
        var innerPlugins = plugins
        if !innerPlugins.contains(where: { (plugin) -> Bool in
            return plugin is NetworkActivityPlugin
        }) {
            /// 网络请求状态栏菊花效果
            let networkActivityPlugin = NetworkActivityPlugin(networkActivityClosure: { (type) in
                switch type {
                case .began:
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                case .ended:
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            })
            innerPlugins.append(networkActivityPlugin)
        }
        
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: innerPlugins, trackInflights: trackInflights)
    }
    
}

