//
//  UpLoadApi.swift
//  SDRequest
//
//  Created by 陈克锋 on 2017/8/1.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import SDRequest

let uploadProvider = SDRequestProvider<UpLoadApi>()

enum UpLoadApi {

    case upload(data: Data)
    
}


extension UpLoadApi: SDRequestable {

    var path: String {
        return "/image"
    }

    var method: HttpMethod {
        return .post
    }
    
//    var parameterEncoding: ParameterEncoding {
//        return SDJSONStringArrayEncoding(array: ["", ""])
//    }
    
    var task: Task {
        switch self {
        case .upload(let data):
            
            return .upload(UploadType.multipart([MultipartFormData(provider: .data(data), name: "fileName")]))
        }
    }
    
    
}
