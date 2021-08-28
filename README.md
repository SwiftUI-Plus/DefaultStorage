![ios](https://img.shields.io/badge/iOS-13-green)
![tv](https://img.shields.io/badge/tvOS-13-green)
![watch](https://img.shields.io/badge/watchOS-6-green)
![mac](https://img.shields.io/badge/macOS-10.15-green)

# DefaultStorage

A dynamic property wrapper that behaves similarly to AppStorage in iOS 14+, providing auto-updating access to UserDefaults.

## Example

```swift
FittingGeometryReader { geo in
    Text("The height is now \(geo.size.height)")
}
```

## Installation

The code is packaged as a framework. You can install manually (by copying the files in the `Sources` directory) or using Swift Package Manager (__preferred__)

To install using Swift Package Manager, add this to the `dependencies` section of your `Package.swift` file:

`.package(url: "https://github.com/SwiftUI-Plus/FittingGeometry.git", .upToNextMinor(from: "1.0.0"))`
