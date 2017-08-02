//
//  SDResponseable.swift
//  Pods
//
//  Created by 陈克锋 on 2017/7/31.
//
//

import UIKit

/// 返回结果协议， 对应的文件格式如： {"code":200, "message":"OK", data: Any}
public protocol SDResponseable {
    
    var code: Int {get}
    
    var message: String {get}
    
}
