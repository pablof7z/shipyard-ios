// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Shipyard",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "Shipyard",
            targets: ["Shipyard"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pablof7z/NDKSwift.git", branch: "master")
    ],
    targets: [
        .target(
            name: "Shipyard",
            dependencies: [
                .product(name: "NDK", package: "NDKSwift"),
                .product(name: "NDKSwiftUI", package: "NDKSwift")
            ]
        ),
    ]
)
