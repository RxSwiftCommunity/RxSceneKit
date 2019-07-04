//
//  SCNPhysicsWorld+Rx.swift
//  RxSceneKit
//
//  Created by Maxim Volgin on 23/02/2019.
//  Copyright (c) RxSwiftCommunity All rights reserved.
//

import SceneKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

public extension Reactive where Base: SCNPhysicsWorld {
    
    public var didBeginContact: Observable<SCNPhysicsContact> {
        
        return Observable.create { observer in
            
            RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
            let uuid = UUID()
            
            if var (delegate, beginners, updaters, enders) = RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base] {
                beginners[uuid] = observer
                RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, beginners, updaters, enders)
            }
            else {
                let delegate = RxSCNPhysicsContactDelegateProxy(for: self.base)
                self.base.contactDelegate = delegate
                RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, [uuid: observer], [:], [:])
            }
            
            return Disposables.create {
                
                RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
                var (delegate, beginners, updaters, enders) = RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base]!
                beginners.removeValue(forKey: uuid)
                
                if beginners.isEmpty && updaters.isEmpty && enders.isEmpty {
                    RxSCNPhysicsContactDelegateProxy.physicsContactDelegates.removeValue(forKey: self.base)
                }
                else {
                    RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, beginners, updaters, enders)
                }
                
            }
            
        }
        
    }

    public var didUpdateContact: Observable<SCNPhysicsContact> {
        
        return Observable.create { observer in
            
            RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
            let uuid = UUID()
            
            if var (delegate, beginners, updaters, enders) = RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base] {
                beginners[uuid] = observer
                RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, beginners, updaters, enders)
            }
            else {
                let delegate = RxSCNPhysicsContactDelegateProxy(for: self.base)
                self.base.contactDelegate = delegate
                RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, [:], [uuid: observer], [:])
            }
            
            return Disposables.create {
                
                RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
                var (delegate, beginners, updaters, enders) = RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base]!
                beginners.removeValue(forKey: uuid)
                
                if beginners.isEmpty && updaters.isEmpty && enders.isEmpty {
                    RxSCNPhysicsContactDelegateProxy.physicsContactDelegates.removeValue(forKey: self.base)
                }
                else {
                    RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, beginners, updaters, enders)
                }
                
            }
            
        }
        
    }
    public var didEndContact: Observable<SCNPhysicsContact> {
        
        return Observable.create { observer in
            
            RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
            let uuid = UUID()
            
            if var (delegate, beginners, updaters, enders) = RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base] {
                enders[uuid] = observer
                RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, beginners, updaters, enders)
            }
            else {
                let delegate = RxSCNPhysicsContactDelegateProxy(for: self.base)
                self.base.contactDelegate = delegate
                RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, [:], [:], [uuid: observer])
            }
            
            return Disposables.create {
                
                RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
                var (delegate, beginners, updaters, enders) = RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base]!
                enders.removeValue(forKey: uuid)
                
                if beginners.isEmpty && updaters.isEmpty && enders.isEmpty {
                    RxSCNPhysicsContactDelegateProxy.physicsContactDelegates.removeValue(forKey: self.base)
                }
                else {
                    RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[self.base] = (delegate, beginners, updaters, enders)
                }
                
            }
            
        }
        
    }
    
}
