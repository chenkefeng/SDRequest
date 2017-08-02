//
//  UserApi.swift
//  SDRequest
//
//  Created by 陈克锋 on 2017/8/1.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import SDRequest

/*
 
 */

let userProvider = SDRequestProvider<UserApi>(plugins:[NetworkLoggerPlugin(verbose: true, cURL: true, output: { (s1: String, s2: String, objs: Any...) in
    print(objs)
})])

enum UserApi {
    case login(username: String, password: String)
    case goodsDetail(String)
}

extension UserApi: SDRequestable {

    var path: String {
        switch self {
        case .login(_, _):
            
            return "/client/auth/login"
        case .goodsDetail(_):
            return "/cms/goods/client/app/details"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .login(let username, let password):
            return ["username": username, "password": password]
        case .goodsDetail(let goodsId):
            return ["goodsId":goodsId]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .login:
            return JSONEncoding.default
        case .goodsDetail:
            return URLEncoding.default
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .login:
            return .post
        case .goodsDetail:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return ["token": "atYXppxTdwKS25r0Kgh5dEq4rSyw7T%2Fd5thK7KJaXiPzIlaPLeg58TFzSxbDly53wBlAsud%2FqUA3wgDHclgKSyDc4cnlWCEbTqE8RcZXv2MkYlcPCvTvkI97Iis7bxCRIkvXawMSfGYcpzD53hg%2FNw%3D%3D",
            "langCode":"en-TH"]
    }

}


extension SDRequestable {
    
    public var baseURL: URL {
        return URL(string: "http://egarage.dev.sudaotech.com/platform")!
    }

}
