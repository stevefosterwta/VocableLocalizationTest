// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "VocableLocalizationTest",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "VocableLocalizationTest", targets: ["VocableLocalizationTest"]),
    ],
    targets: [
        .target(name: "VocableLocalizationTest", path "Presets", dependencies: [])
    ]
)
