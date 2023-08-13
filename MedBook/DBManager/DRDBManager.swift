//
//  DRDBManager.swift
//  MedBook
//
//  Created by Ritik Raj on 13/08/23.
//

import Foundation

protocol DRDatabaseManager {
    func getKey<T: Codable>(key: String)->T?
    func setKey<T: Codable>(key: String, object: T) -> DRDatabaseManagerResult
    func removeKey(key: String)
}

protocol UserSessionStorage {
    var loggedInUserEmail: String? { get set }
}

public enum DRDatabaseManagerResult {
    case success
    case failure
}

public class UserDefaultDBManager: DRDatabaseManager {
    public func getKey<T: Codable>(key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        let userData = try? JSONDecoder().decode(T.self, from: data)
        return userData
    }
    
    @discardableResult
    public func setKey<T: Codable>(key: String, object: T) -> DRDatabaseManagerResult {
        if let data = try? JSONEncoder().encode(object) {
            UserDefaults.standard.set(data, forKey: key)
            return .success
        } else {
            return .failure
        }
    }
    
    public func removeKey(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

extension UserDefaultDBManager: UserSessionStorage {
    var loggedInUserEmail: String? {
        get { return self.getKey(key: DRKeyConstants.loggenInUserKey) }
        set { self.setKey(key: DRKeyConstants.loggenInUserKey, object: newValue) }
    }
}
