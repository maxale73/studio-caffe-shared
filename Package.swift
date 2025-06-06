// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "studio-caffe-shared",
    platforms: [
        .macOS("15.0"), .iOS("18.0")
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "studio-caffe-shared",
            targets: ["studio-caffe-shared"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "studio-caffe-shared",
            dependencies: [],
            swiftSettings: []),
        
        .testTarget(
            name: "studio-caffe-sharedTests",
            dependencies: ["studio-caffe-shared"],
            resources: [.copy("ELKATT_sample.txt"),
                        .copy("ELKATT_old_sample.txt"),
                        .copy("missingReportOldFile.txt"),
                        .copy("missingReportNewFile.txt"),
                        .copy("controllo_cassa_new.txt"),
                        .copy("controllo_cassa_old.txt")]),
    ]
)
