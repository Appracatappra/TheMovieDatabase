// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TheMovieDatabase",
    platforms: [.iOS(.v18), .macOS(.v15), .tvOS(.v18), .watchOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TheMovieDatabase",
            targets: ["TheMovieDatabase"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/Appracatappra/LogManager", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/Appracatappra/SwiftletUtilities", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/Appracatappra/SimpleSerializer", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/Appracatappra/UrlUtilities", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TheMovieDatabase",
            dependencies: ["LogManager", "SwiftletUtilities", "SimpleSerializer", "UrlUtilities"],
            resources: [.process("Resources")],
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        ),
        .testTarget(
            name: "TheMovieDatabaseTests",
            dependencies: ["TheMovieDatabase"]
        ),
    ]
)
