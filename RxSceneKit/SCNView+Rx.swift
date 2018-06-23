//
//  SCNView+Rx.swift
//  RxSceneKit
//
//  Created by Maxim Volgin on 23/06/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import SceneKit
import RxSwift
import RxCocoa

extension Reactive where Base: SCNView {
    /// Reactive wrapper for `delegate`.
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var delegate: DelegateProxy<SCNView, SCNSceneRendererDelegate> {
        return RxSCNSceneRendererDelegateProxy.proxy(for: base)
    }
    
    /// Installs delegate as forwarding delegate on `delegate`.
    /// Delegate won't be retained.
    ///
    /// It enables using normal delegate mechanism with reactive delegate mechanism.
    ///
    /// - parameter delegate: Delegate object.
    /// - returns: Disposable object that can be used to unbind the delegate.
    public func setDelegate(_ delegate: SCNSceneRendererDelegate)
        -> Disposable {
            return RxSCNSceneRendererDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: self.base)
    }
    
    // MARK:- SCNSceneRendererDelegate
    
//    optional public func renderer(_ renderer: SCNSceneRenderer, didApplyAnimationsAtTime time: TimeInterval)
//    optional public func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval)
//    optional public func renderer(_ renderer: SCNSceneRenderer, didApplyConstraintsAtTime time: TimeInterval)
//    optional public func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval)
//    optional public func renderer(_ renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval)
    
    // Reactive wrapper for delegate method `renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)`
    public var updateAtTime: ControlEvent<TimeInterval> {
        let source = delegate
            .methodInvoked(#selector(SCNSceneRendererDelegate.renderer(_:updateAtTime:)))
            .map { value -> TimeInterval in
                return try castOrThrow(TimeInterval.self, value[1] as AnyObject)
        }
        return ControlEvent(events: source)
    }
    
    
    
    
}
