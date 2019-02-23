//
//  RxSCNPhysicsContactDelegateProxy.swift
//  RxSceneKit
//
//  Created by Maxim Volgin on 23/02/2019.
//  Copyright © 2019 Maxim Volgin. All rights reserved.
//

import SceneKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class RxSCNPhysicsContactDelegateProxy: NSObject, SCNPhysicsContactDelegate {
    
    static var physicsContactDelegates: [SCNPhysicsWorld: (SCNPhysicsContactDelegate, [UUID: AnyObserver<SCNPhysicsContact>], [UUID: AnyObserver<SCNPhysicsContact>], [UUID: AnyObserver<SCNPhysicsContact>])] = [:]
    static let physicsContactDelegatesLock = NSRecursiveLock()
    
    let world: SCNPhysicsWorld
    
    init(for world: SCNPhysicsWorld) {
        self.world = world
        super.init()
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
        RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
        let (_, beginners, _, _) = RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[world]!
        
        for each in beginners.values {
            each.onNext(contact)
        }
        
    }

    func physicsWorld(_ world: SCNPhysicsWorld, didUpdate contact: SCNPhysicsContact) {
        
        RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
        let (_, _, updaters, _) = RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[world]!
        
        for each in updaters.values {
            each.onNext(contact)
        }
        
    }

    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        
        RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.lock(); defer { RxSCNPhysicsContactDelegateProxy.physicsContactDelegatesLock.unlock() }
        let (_, _, _, enders) = RxSCNPhysicsContactDelegateProxy.physicsContactDelegates[world]!
        
        for each in enders.values {
            each.onNext(contact)
        }
        
    }
    
}
