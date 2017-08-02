//
//  ObservableType+Biz.swift
//  Pods
//
//  Created by 陈克锋 on 2017/8/1.
//
//

import UIKit
import RxSwift
import Moya

public extension ObservableType where E: SDResponseable{
    
    func sd_subscribe(onBizError: ((SDResponseable)->())? = nil, onNext: ((E) -> Void)? = nil, onError: ((Swift.Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil)
        -> Disposable {
            
            let disposable: Disposable
            
            if let disposed = onDisposed {
                disposable = Disposables.create(with: disposed)
            }
            else {
                disposable = Disposables.create()
            }
            
            let observer = SDAnonymousObserver<E> { e in
                switch e {
                case .next(let value):
                    if value.code != 200 {
                        onBizError?(value)
                        return
                    }
                    onNext?(value)
                case .error(let e):
                    onError?(e)
                    disposable.dispose()
                case .completed:
                    onCompleted?()
                    disposable.dispose()
                }
            }
            return Disposables.create(
                sd_subscribeSafe(observer),
                disposable
            )
    }
}


extension ObservableType {
    
    fileprivate func sd_subscribeSafe<O: ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return self.asObservable().subscribe(observer)
    }
}




final class SDAnonymousObserver<ElementType> : SDObserverBase<ElementType> {
    typealias Element = ElementType
    
    typealias EventHandler = (Event<Element>) -> Void
    
    private let _eventHandler : EventHandler
    
    init(_ eventHandler: @escaping EventHandler) {
        #if TRACE_RESOURCES
            let _ = Resources.incrementTotal()
        #endif
        _eventHandler = eventHandler
    }
    
    override func onCore(_ event: Event<Element>) {
        return _eventHandler(event)
    }
    
    #if TRACE_RESOURCES
    deinit {
    let _ = Resources.decrementTotal()
    }
    #endif
}



class SDObserverBase<ElementType> : Disposable, ObserverType {
    typealias E = ElementType
    
    private var _isStopped: Int32 = 0
    
    func on(_ event: Event<E>) {
        switch event {
        case .next:
            if _isStopped == 0 {
                onCore(event)
            }
        case .error, .completed:
            
            if OSAtomicCompareAndSwap32Barrier(0, 1, &_isStopped) {
                onCore(event)
            }
        }
    }
    
    func onCore(_ event: Event<E>) {
        fatalError("子类需要实现的方法")
    }
    
    func dispose() {
        _ = OSAtomicCompareAndSwap32Barrier(0, 1, &_isStopped)
    }
}
