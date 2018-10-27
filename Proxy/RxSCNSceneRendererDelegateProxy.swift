//
//  RxSCNSceneRendererDelegateProxy.swift
//  RxSceneKit
//
//  Created by Maxim Volgin on 23/06/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import SceneKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

public typealias RxSCNRendererDelegate = DelegateProxy<SCNView, SCNSceneRendererDelegate>

extension SCNView: HasDelegate {
    public typealias Delegate = SCNSceneRendererDelegate
}

open class RxSCNSceneRendererDelegateProxy: RxSCNRendererDelegate, DelegateProxyType, SCNSceneRendererDelegate {
    
    /// Type of parent object
    public weak private(set) var view: SCNView?
    
    /// Init with ParentObject
    public init(parentObject: ParentObject) {
        view = parentObject
        super.init(parentObject: parentObject, delegateProxy: RxSCNSceneRendererDelegateProxy.self)
    }
    
    /// Register self to known implementations
    public static func registerKnownImplementations() {
        self.register { parent -> RxSCNSceneRendererDelegateProxy in
            RxSCNSceneRendererDelegateProxy(parentObject: parent)
        }
    }
    
    /// Gets the current `SCNSceneRendererDelegate` on `SCNView`
    open class func currentDelegate(for object: ParentObject) -> SCNSceneRendererDelegate? {
        return object.delegate
    }
    
    /// Set the `SCNSceneRendererDelegate` for `SCNView`
    open class func setCurrentDelegate(_ delegate: SCNSceneRendererDelegate?, to object: ParentObject) {
        object.delegate = delegate
    }

}

