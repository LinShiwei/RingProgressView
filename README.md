
![License](https://img.shields.io/badge/Language-Swift-brightgreen.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


# RingProgressView

An view for showing progress.

## Quick Look

![image](/RingProgressView1.gif)

## Installation

### Carthage

Using [Carthage](https://github.com/Carthage/Carthage):

```
github "LinShiwei/RingProgressView"
```

### Manually

- Just include the `RingProgressView.swift` files found on the `RingProgressView` folder.

## Usage 

Create a ringProgressView and add it to your view's subviews:

```swift
let ringProgressView = RingProgressView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
view.addSubview(ringProgressView)
```

Now your can customize it using its `setting` method. For example:

```swift
ringProgressView.setting(dotCount: 60, hasRing:false)
```

The default setting is:

- dotCount = 60
- dotRadius = 1 
- dotColor = UIColor.white
- dotBackgroundColor = UIColor.darkGray
- hasRing = true
- GapBetweenRingAndDot = 4 
- ringLineWidth = 1
- ringLineColor = UIColor(white: 1, alpha: 0.2) 
- animationDuration = 1
- direction = .Counterclockwise

**The most important thing is your can set ringProgressView's property `progress` to change the progress.**

`progress` is in [0,1]. Any value outside the range set to `progress` will be adjust to 0 or 1. So feel safe to set this property.

The moment your set value to `progress`, the animation begin. Just like the demo gif shows above.


## Suggestion

- The frame of RingProgressView is set after creating. Setting the new frame to it will not change the size of the progress view. If you want to change its size after init, you can set its `transform` property.

- It's nicer to setting a suitable frame, dotCount and dotRadius.

- If you don't want to show the ring inside the dot ring, you can set `hasRing:false` in the `setting` method.


