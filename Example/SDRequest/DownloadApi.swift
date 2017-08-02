//
//  DownloadApi.swift
//  SDRequest
//
//  Created by 陈克锋 on 2017/8/1.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import SDRequest

let downloadProvider = SDRequestProvider<DownloadApi>()

enum DownloadApi {
    case download(DownloadDestination)
}


extension DownloadApi: SDRequestable {

    var baseURL: URL {
        return URL(string: "http://files.playplus.me")!
    }
    
    var path: String {
        return "/wk_vid_2c08d191d1e4457e94229ae5bd51a708"
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var task: Task {
        
        switch self {
        case .download(let destination):
            return .download(DownloadType.request(destination))
        }
    }
    
}
