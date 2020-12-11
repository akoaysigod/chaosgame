// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "chaos-game",
  platforms: [
    .macOS(.v10_11)
  ],
  products: [
    .executable(
      name: "chaos-game",
      targets: ["chaos-game"]
    ),
  ],
  targets: [
    .target(
      name: "chaos-game",
      dependencies: ["SDL"]
    ),
    .systemLibrary(
      name: "SDL",
      pkgConfig: "sdl2",
      providers: [
        .brew(["sdl2"]),
      ]
    ),
  ]
)
