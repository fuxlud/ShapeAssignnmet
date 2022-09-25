import Foundation

protocol LocalStorage {
    func object(forKey defaultName: String) -> Any?
    func set(_ value: Any?, forKey defaultName: String)
    func data(forKey defaultName: String) -> Data?
}

extension UserDefaults: LocalStorage {}
