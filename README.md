![ios](https://img.shields.io/badge/iOS-13-green)
![tv](https://img.shields.io/badge/tvOS-13-green)
![watch](https://img.shields.io/badge/watchOS-6-green)
![mac](https://img.shields.io/badge/macOS-10.15-green)

----

> This library and all other backports in the SwiftUI+ collection, have now been migrated into a single Backports library, with a LOT more additions. This should simply my efforts and allow me and others to contribute more backports in the near future.
> [SwiftUI Backports](https://shaps80/SwiftUIBackports)

# DefaultStorage

----

> Also available as a part of my [SwiftUI+ Collection](https://benkau.com/packages.json) – just add it to Xcode 13+

A dynamic property wrapper that behaves similarly to AppStorage in iOS 14+, providing auto-updating access to UserDefaults.

## Example

```swift
@DefaultStorage("name") private var name: String
```

## Installation

The code is packaged as a framework. You can install manually (by copying the files in the `Sources` directory) or using Swift Package Manager (**preferred**)

To install using Swift Package Manager, add this to the `dependencies` section of your `Package.swift` file:

`.package(url: "https://github.com/SwiftUI-Plus/DefaultStorage.git", .upToNextMinor(from: "1.0.0"))`

## Other Packages

If you want easy access to this and more packages, add the following collection to your Xcode 13+ configuration:

`https://benkau.com/packages.json`
