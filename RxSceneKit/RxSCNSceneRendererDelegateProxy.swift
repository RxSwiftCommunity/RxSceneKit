//
//  RxSCNSceneRendererDelegateProxy.swift
//  RxSceneKit
//
//  Created by Maxim Volgin on 23/06/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import SceneKit
import RxSwift
import RxCocoa

extension SCNView: HasDelegate {
    public typealias Delegate = SCNSceneRendererDelegate
}

open class RxSCNSceneRendererDelegateProxy:
    DelegateProxy<SCNView, SCNSceneRendererDelegate>,
    DelegateProxyType,
    SCNSceneRendererDelegate {
    
    /// Typed parent object.
    public weak private(set) var view: SCNView?
    
    /// - parameter view: Parent object for delegate proxy.
    public init(view: ParentObject) {
        self.view = view
        super.init(parentObject: view, delegateProxy: RxSCNSceneRendererDelegateProxy.self)
    }
    
    // Register known implementationss
    public static func registerKnownImplementations() {
        self.register { RxSCNSceneRendererDelegateProxy(view: $0) }
    }
}
