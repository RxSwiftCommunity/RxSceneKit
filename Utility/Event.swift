//
//  Event.swift
//  RxSceneKit
//
//  Created by Maxim Volgin on 27/10/2018.
//  Copyright (c) RxSwiftCommunity All rights reserved.
//

import SceneKit

// MARK: - SCNSceneRendererDelegate

public typealias EventTime = (renderer: SCNSceneRenderer, time: TimeInterval)
public typealias EventRender = (renderer: SCNSceneRenderer, scene: SCNScene, time: TimeInterval)
