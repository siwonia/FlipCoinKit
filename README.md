FlipCoinKit
===========

### About
FlipCoinKit is an open source framework to let images in your iOS app flip like a coin.

### Initialize
```swift
// create an UIView or use one from your storyboard
let yourUIViewFrame = CGRect(x: 0, y: 0, width: 200, height: 200)
let yourUIView = UIView(frame: yourUIViewFrame)
self.view.addSubview(yourUIView)

// create a manager
let manager = FlipCoinManager(
  view: yourUIView,
  images: [
    UIImage(named: "image-one")!,
    UIImage(named: "image-two")!,
    UIImage(named: "image-three")!
  ]
)
```

### Start flipping
```swift
// start infinite flipping
manager.startFlipping()
```

### Stop flipping
```swift
let indexOfUIImage = 0

// stop flipping immediately
manager.stopFlipping(indexOfUIImage)

// stop flipping as soon as image with index is reached
manager.stopFlipping(indexOfUIImage) {
  // callback
}
```
