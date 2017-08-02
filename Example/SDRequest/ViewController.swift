//
//  ViewController.swift
//  SDRequest
//
//  Created by chenkefeng_java@163.com on 07/31/2017.
//  Copyright (c) 2017 chenkefeng_java@163.com. All rights reserved.
//

import UIKit
import SDRequest
import RxSwift
import Alamofire

class ViewController: UIViewController {
    
    let disposeBag: DisposeBag = DisposeBag()
    
    lazy var viewModel: DemoVM = DemoVM()

    @IBAction func doPost(_ sender: Any) {
        
        viewModel.requestProvider.disposed(by: disposeBag)
        
        
    }
    
    @IBAction func doGet(_ sender: Any) {
        userProvider
            .request(.goodsDetail("17611"))
            .mapObject(RespModel<String>.self)
            .sd_subscribe(onBizError: { (bizError) in
                print(bizError)
            }, onNext: { (respModel) in
                print(respModel)
            }, onError: { (error) in
                print(error)
            }, onCompleted: { 
                
            }) { 
                
            }.disposed(by: disposeBag)
    }
    
    @IBAction func doUpload(_ sender: Any) {
        guard let data = UIImagePNGRepresentation(UIImage(named: "abc")!) else {return}
        uploadProvider
            .requestWithProgress(UpLoadApi.upload(data: data))
            .subscribe(onNext: { (pr: ProgressResponse) in
                
                print(pr.progress)
                
                if let response = pr.response {
                    do{
                        // 成功了
                        let resp = try response.mapObject(RespModel<[String]>.self)
                        print(resp)
                    }catch{
                        print(error)
                    }
                }
                
            }, onError: { (error) in
                
            }, onCompleted: { 
                
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func doDownload(_ sender: Any) {
        
        /// 直接使用 Alamofire 感觉更简单
//        download("http://files.playplus.me/wk_vid_2c08d191d1e4457e94229ae5bd51a708", to: { (url, resp) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
//            return (URL(string: "file:///Users/sfuser/Desktop/aa.mp4")!, [.createIntermediateDirectories, .removePreviousFile])
//        }).downloadProgress { (progress) in
//            print(progress.totalUnitCount, progress.completedUnitCount, CGFloat(progress.completedUnitCount) / CGFloat(progress.totalUnitCount))
//            }.responseData { (resp: DownloadResponse<Data>) in
//                print(resp.result.value ?? "")
//        }
        
        //// 使用封装之后的api，获取不到最终的data, 需要从目标地址中重新加载
        downloadProvider.requestWithProgress(DownloadApi.download({ (url, response) -> (destinationURL: URL, options: DownloadOptions) in
            return (URL(string: "file:///Users/sfuser/Desktop/aa.mp4")!, [.createIntermediateDirectories, .removePreviousFile])
        })).subscribe(onNext: { (pr: ProgressResponse) in
            print(pr.progress)
            
        }, onError: { (error) in
            
        }, onCompleted: { 
            
        }).disposed(by: disposeBag)
    }
}

