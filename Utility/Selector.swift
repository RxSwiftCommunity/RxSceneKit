//
//  Selector.swift
//  RxSceneKit
//
//  Created by Maxim Volgin on 27/10/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import SceneKit

// MARK: - SCNSceneRendererDelegate

extension Selector {
    static let updateAtTime = #selector(SCNSceneRendererDelegate.renderer(_:updateAtTime:))
    static let didApplyAnimationsAtTime = #selector(SCNSceneRendererDelegate.renderer(_:didApplyAnimationsAtTime:))
    static let didSimulatePhysicsAtTime = #selector(SCNSceneRendererDelegate.renderer(_:didSimulatePhysicsAtTime:))
    static let didApplyConstraintsAtTime = #selector(SCNSceneRendererDelegate.renderer(_:didApplyConstraintsAtTime:))
    static let willRenderSceneAtTime = #selector(SCNSceneRendererDelegate.renderer(_:willRenderScene:atTime:))
    static let didRenderSceneAtTime = #selector(SCNSceneRendererDelegate.renderer(_:didRenderScene:atTime:))
}
