# TheMovieDatabase

![](https://img.shields.io/badge/license-MIT-green) ![](https://img.shields.io/badge/maintained%3F-Yes-green) ![](https://img.shields.io/badge/swift-6.1-green) ![](https://img.shields.io/badge/iOS-18.0-red) ![](https://img.shields.io/badge/macOS-15.0-red) ![](https://img.shields.io/badge/tvOS-18.0-red) ![](https://img.shields.io/badge/watchOS-11.0-red) ![](https://img.shields.io/badge/dependency-LogManager-orange) ![](https://img.shields.io/badge/dependency-SwiftletUtilities-orange)

`TheMovieDatabase` makes it easy to include content from the [The Movie Database](https://www.themoviedb.org/?language=en-US) in a Swift app.

> WARNING! Access to **The Movie Database** requires an **API Key** that can be requested from the **The Movie Database** Website ([https://www.themoviedb.org](https://www.themoviedb.org/?language=en-US)) For **Commercial** use, a **Commercial License** MUST be acquired from **The Movie Database Sales Team**. See the [FAQ](https://developer.themoviedb.org/docs/faq) for full details.

## Support

If you find `TheMovieDatabase` useful and would like to help support its continued development and maintenance, please consider making a small donation, especially if you are using it in a commercial product:

<a href="https://www.buymeacoffee.com/KevinAtAppra" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

It's through the support of contributors like yourself, I can continue to build, release and maintain high-quality, well documented Swift Packages like `TheMovieDatabase  for free.

## Installation

**Swift Package Manager** (Xcode 11 and above)

1. In Xcode, select the **File** > **Add Package Dependency…** menu item.
2. Paste `https://github.com/Appracatappra/TheMovieDatabase.git` in the dialog box.
3. Follow the Xcode's instruction to complete the installation.

> Why not CocoaPods, or Carthage, or etc?

Supporting multiple dependency managers makes maintaining a library exponentially more complicated and time consuming.

Since, the **Swift Package Manager** is integrated with Xcode 11 (and greater), it's the easiest choice to support going further.

## Overview

TODO: Add content here.

### Embedded Graphic

There is one embedded logo in `OpenTriviaDatabase`:

* `OTDLogo.png` - The official **Open Trivia Database** logo.

### The OpenTriviaDatabase Class

The `TheMovieDatabase` provides a few helper utilities that allow you to easily access resources stored in the Swift Package (such as the image above).

For example, the following code would return the path to the `OTDLogo.png` file:

```
let path = TheMovieDatabase.pathTo(resource:"OTDLogo.png")
```

# Documentation

The **Package** includes full **DocC Documentation** for all of its features.
