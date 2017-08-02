//
//  LoginRespModel.swift
//  SDRequest
//
//  Created by 陈克锋 on 2017/8/1.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON
import SDRequest

struct LoginRespDataModel: HandyJSON {
    var cellphone: String = ""
    var token: String = ""
}

struct RespModel<T: HandyJSON>: HandyJSON, SDResponseable {

    var code: Int = 0
    var message: String = ""
    
    var data: T = T()
    
    
}
