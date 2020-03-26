import Foundation

extension Bundle {
    
    static var testBundle: Bundle {
        let optionalTestBundle = allBundles.first { $0.bundlePath.hasSuffix(".xctest") }
        guard let testBundle = optionalTestBundle else {
            fatalError("Could not find test bundle")
        }
        
        return testBundle
    }
    
}
