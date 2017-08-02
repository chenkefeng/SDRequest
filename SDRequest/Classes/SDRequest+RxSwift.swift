//
//  SDRequest+RX.swift
//  Pods
//
//  Created by 陈克锋 on 2017/7/31.
//
//

import UIKit
import Moya
import RxSwift
import HandyJSON

public extension ObservableType where E: Response {

    public func mapObject<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(type))
        }
    }
    
    
    public func mapArray<T: HandyJSON>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(type))
        }
    }
    
}

public extension Response {

    
    /// 把服务器返回的数据映射为HandyJSON的对象
    ///
    /// - Parameter type: 结果类型
    /// - Returns: 对应的结果
    /// - Throws: 异常
    public func mapObject<T: HandyJSON>(_ type: T.Type) throws -> T {
        do {
            if let result = T.deserialize(from: try mapString()) {
                return result
            }
            throw MoyaError.jsonMapping(self)
        } catch {
            throw MoyaError.jsonMapping(self)
        }
    }
    
    /// 把服务器返回的数据映射为HandyJSON的数组对象
    ///
    /// - Parameter type: 数组元素的类型
    /// - Returns: 对应元素类型的数组
    /// - Throws: 异常
    public func mapArray<T: HandyJSON>(_ type: T.Type) throws -> [T] {
        do {
            if let result = Array<T>.deserialize(from: try mapString()) {
                return result.map({ (ele) -> T in
                    return ele == nil ? T() : ele!
                })
            }
            throw MoyaError.jsonMapping(self)
        } catch {
            throw MoyaError.jsonMapping(self)
        }
    }


}


