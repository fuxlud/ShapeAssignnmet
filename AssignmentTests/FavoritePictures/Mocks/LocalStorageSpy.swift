import XCTest
@testable import Assignment

class LocalStorageSpy: LocalStorage {
    
    var observedDictionary: [String: Any?] = [:]
    
    func object(forKey defaultName: String) -> Any? {
        return observedDictionary[defaultName] as Any?
    }
    
    func set(_ value: Any?, forKey defaultName: String) {
        observedDictionary[defaultName] = value
    }
    
    func data(forKey defaultName: String) -> Data? {
        return Data()
    }
}
