FlipCoinKit
===========

### About

FlipCoinKit is an open source framework to let images in your iOS app flip like a coin.

### Initialize

``` Swift
// create an UIView or use one from your storyboard
let yourUIView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
self.view.addSubview(yourUIView)

// create a manager
let flipCoinManager = FlipCoinManager(
  view: yourUIView,
  images: [
    UIImage(named: "image-one")!,
    UIImage(named: "image-two")!,
    UIImage(named: "image-three")!
  ]
)
```
