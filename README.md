# RxSceneKit
RxSceneKit (based on RxSwift)

Basic usage.

```swift

scnView.
    .rx
    .updateAtTime
    .subscribe { event in
        switch event {
        case .next(let updateAtTime):
            // TODO: ...
            break
        default:
            break
        }
    }
    .disposed(by: disposeBag)
    
physicsWorld
    .rx
    .didBeginContact
    .subscribe { event in
        switch event {
        case .next(let didBeginContact):
            // TODO: ...
            break
        default:
            break
        }
    }
    .disposed(by: disposeBag)
```

Carthage setup.

```
github "maxvol/RxSceneKit" ~> 0.1.1

```

