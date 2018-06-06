// swift-tools-version:4.0
// Generated automatically by Perfect Assistant
// Date: 2018-06-06 07:02:43 +0000
import PackageDescription

let package = Package(
	name: "MyAwesomeProject",
	dependencies: [
		.package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", "3.0.0"..<"4.0.0")
	],
	targets: [
		.target(name: "MyAwesomeProject", dependencies: ["PerfectHTTPServer"])
	]
)
