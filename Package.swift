// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "opentelemetry-swift",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11),
        .tvOS(.v11)
    ],
    products: [
        .library(name: "OpenTelemetryApi", type: .static, targets: ["OpenTelemetryApi"]),
        .library(name: "OpenTelemetrySdk", type: .static, targets: ["OpenTelemetrySdk"]),
        .library(name: "OpenTelemetryProtocolExporterHTTP", type: .static, targets: ["OpenTelemetryProtocolExporterHttp"]),
    ],
    dependencies: [
        .package(name: "swift-protobuf", url: "https://github.com/apple/swift-protobuf.git", from: "1.20.2"),
        .package(name: "swift-log", url: "https://github.com/apple/swift-log.git", from: "1.4.4"),
        .package(name: "swift-metrics", url: "https://github.com/apple/swift-metrics.git", from: "2.1.1")
    ],
    targets: [
        .target(name: "OpenTelemetryApi",
                dependencies: []),
        .target(name: "OpenTelemetrySdk",
                dependencies: ["OpenTelemetryApi"]),
        .target(name: "OpenTelemetryProtocolExporterCommon",
                dependencies: ["OpenTelemetrySdk",
                               .product(name: "Logging", package: "swift-log"),
                               .product(name: "SwiftProtobuf", package: "swift-protobuf")],
                path: "Sources/Exporters/OpenTelemetryProtocolCommon"),
        .target(name: "OpenTelemetryProtocolExporterHttp",
                dependencies: ["OpenTelemetrySdk",
                               "OpenTelemetryProtocolExporterCommon"],
                path: "Sources/Exporters/OpenTelemetryProtocolHttp")
    ]
)
