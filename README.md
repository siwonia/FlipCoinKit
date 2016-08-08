FlipCoinKit
===========

### About
FlipCoinKit is an open source iOS library to let you images flip like a coin.

![FlipCoinKit](https://raw.githubusercontent.com/schultka/FlipCoinKit/master/flip-coin.gif)

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

// change flipping speed if you like
manager.speed = 0.15
```

### Start flipping
```swift
// start infinite flipping
manager.startFlipping()
```

### Stop flipping
```swift
let imageIndex = 0

// stop flipping immediately
manager.stopFlipping()

// stop flipping immediately and show image with index
manager.stopFlipping(imageIndex)

// stop flipping as soon as image with index is reached
manager.stopFlipping(imageIndex) {
  // callback
}
```
