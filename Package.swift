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
            swiftSettings: [
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_FORWARD_TRAILING_CLOSURES"),
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_CONCISE_MAGIC_FILE"),
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_IMPORT_MODULE_AS_PATH"),
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_DEPRECATE_APPLICATION_MAIN"),
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_DISABLE_OUTWARD_ACTOR_ISOLATION"),
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_GLOBAL_ACTOR_ISOLATED_TYPES_USABILITY"),
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_IMPLICIT_OPEN_EXISTENTIALS"),
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_IMPORT_OBJC_FORWARD_DECLS"),
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_INFER_SENDABLE_FROM_CAPTURES"),
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_ISOLATED_DEFAULT_VALUES"),
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_GLOBAL_CONCURRENCY"),
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_MEMBER_IMPORT_VISIBILITY"),
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_NONFROZEN_ENUM_EXHAUSTIVITY"),
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_REGION_BASED_ISOLATION"),
                    .enableUpcomingFeature("SWIFT_UPCOMING_FEATURE_EXISTENTIAL_ANY"),
                    .enableUpcomingFeature("SWIFT_STRICT_CONCURRENCY"),
                ]),
        
        .testTarget(
            name: "studio-caffe-sharedTests",
            dependencies: ["studio-caffe-shared"]),
    ]
)
