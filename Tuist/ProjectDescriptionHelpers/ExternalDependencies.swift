import ProjectDescription

public struct SPMDependency: Sendable {
    let url: String
    let name: String
    let requirement: Package.Requirement

    var package: Package {
        .remote(url: url, requirement: requirement)
    }

    var targetDependency: TargetDependency {
        .package(product: name)
    }
}

public extension SPMDependency {

    static let ollama = SPMDependency(
        url: "https://github.com/mattt/ollama-swift.git",
        name: "Ollama",
        requirement: .exact("1.2.0")
    )

}
