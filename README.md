# FloatingTabView
A custom TabView in SwiftUI

[![Language](https://img.shields.io/badge/swift-5.5-green.svg)](https://swift.org)
[![Build Status](https://travis-ci.org/ferranabello/Viperit.svg?branch=master)](https://travis-ci.org/ferranabello/Viperit)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![SwiftUI compatible](https://img.shields.io/badge/SwiftUI-compatible-green.svg)](https://developer.apple.com/xcode/swiftui/)

![Alt Text](./Resources/FloatingTabView.gif)

FloatingTabView is a very lightweight custom TabView in SwiftUI. 

The differences between it and the other Custom TabView are:

* FloatingTabView follows the standard TabView API. You can integrate it with very few lines of code:

* FloatingTabView is lightweight: it is written in less than 200 lines of code.


# Installation

## Requirements

* iOS 13.0+
* Xcode 11.0+

## Swift Package Manager (SPM)

You can simply install the framework using the following url to add the Swift Package

```
https://github.com/Gioevi90/FloatingTabView.git
```

Then you can import the framework using the command

```
import FloatingTabView
```

# How to use it

The code is really simple: you just have to embed you views into the FloatingTabViewItem passing the systemImage name you want to use to the initializer.

# Future improvements

* Implement different styles
* Implement custom image support
* Implement Carthage support
* Implement CocoaPods support