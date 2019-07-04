//
//  SCNView+Rx.swift
//  RxSceneKit
//
//  Created by Maxim Volgin on 23/06/2018.
//  Copyright (c) RxSwiftCommunity All rights reserved.
//

import SceneKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

extension Reactive where Base: SCNView {
    
    // MARK: - SCNSceneRendererDelegate
    
    public var updateAtTime: ControlEvent<EventTime> {
        let source: Observable<EventTime> = delegate
            .methodInvoked(.updateAtTime)
            .map(toEventTime)
        return ControlEvent(events: source)
    }
    
    public var didApplyAnimationsAtTime: ControlEvent<EventTime> {
        let source: Observable<EventTime> = delegate
            .methodInvoked(.didApplyAnimationsAtTime)
            .map(toEventTime)
        return ControlEvent(events: source)
    }
    
    public var didSimulatePhysicsAtTime: ControlEvent<EventTime> {
        let source: Observable<EventTime> = delegate
            .methodInvoked(.didSimulatePhysicsAtTime)
            .map(toEventTime)
        return ControlEvent(events: source)
    }
    
    public var didApplyConstraintsAtTime: ControlEvent<EventTime> {
        let source: Observable<EventTime> = delegate
            .methodInvoked(.didApplyConstraintsAtTime)
            .map(toEventTime)
        return ControlEvent(events: source)
    }
    
    public var willRenderSceneAtTime: ControlEvent<EventRender> {
        let source: Observable<EventRender> = delegate
            .methodInvoked(.willRenderSceneAtTime)
            .map(toEventRender)
        return ControlEvent(events: source)
    }
    
    public var didRenderSceneAtTime: ControlEvent<EventRender> {
        let source: Observable<EventRender> = delegate
            .methodInvoked(.didRenderSceneAtTime)
            .map(toEventRender)
        return ControlEvent(events: source)
    }
    
    // MARK: -
    
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
    
}

