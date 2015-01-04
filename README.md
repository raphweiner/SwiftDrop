# SwiftDrop

A tiny dropdown library for usage with `UINavigationController` in Swift.

![](swift-drop.gif)

## Usage

1. Import `SwiftDrop.swift`

2. Setup within your desired view controller:

```swift
swiftDrop = SwiftDrop()
swiftDrop.menuItems = ["Two roads diverged", "Then took the other"]
swiftDrop.navigationController = navigationController
swiftDrop.delegate = self
```

See the embedded SwiftDropExample project for a working example.

## License

This repository is licensed under the MIT license, more under
[LICENSE](LICENSE).
