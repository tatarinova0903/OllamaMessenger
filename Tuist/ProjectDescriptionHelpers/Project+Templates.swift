import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func app(
        name: String,
        organizationName: String,
        spmDependencies: [SPMDependency]
    ) -> Project {
        let targets = makeAppTargets(
            name: name,
            organizationName: organizationName,
            spmDependencies: spmDependencies
        )
        return Project(
            name: name,
            organizationName: organizationName,
            packages: spmDependencies.map { $0.package },
            targets: targets,
            resourceSynthesizers: []
        )
    }

    // MARK: - Private
    /// Helper function to create the application target and the unit test target.
    private static func makeAppTargets(
        name: String,
        organizationName: String,
        spmDependencies: [SPMDependency]
    ) -> [Target] {
        let infoPlist: [String: Plist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1"
        ]

        let mainTarget = Target.target(
            name: name,
            destinations: .macOS,
            product: .app,
            bundleId: "\(organizationName).\(name)",
            deploymentTargets: .macOS("14.0"),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            dependencies: spmDependencies.map { $0.targetDependency }
        )

        return [mainTarget]
    }
}
