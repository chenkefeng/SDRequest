//
//  DemoVM.swift
//  SDRequest
//
//  Created by 陈克锋 on 2017/8/1.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import SDRequest
import RxSwift
class DemoVM {
    

    var requestProvider: Disposable {
        
        return
            userProvider
            .request(.login(username: "huang111", password: "111111"))
            .mapObject(RespModel<LoginRespDataModel>.self)
            .sd_subscribe(onBizError: { (bizError) in
                print("业务错误", bizError.code , bizError.message)
                ///-------
            }, onNext: { (respModel) in
                print(respModel)
            }, onError: { (error) in
                print("请求错误", error)
            })
    }
    
    func doRequest() -> Disposable {
        
        return
            userProvider
                .request(.login(username: "huang111", password: "111111"))
                .mapObject(RespModel<LoginRespDataModel>.self)
                .sd_subscribe(onBizError: { (bizError) in
                    print("业务错误", bizError.code , bizError.message)
                    ///-------
                }, onNext: { (respModel) in
                    print(respModel)
                }, onError: { (error) in
                    print("请求错误", error)
                })
    }
    
}




