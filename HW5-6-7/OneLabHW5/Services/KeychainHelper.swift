//
//  KeychainHelper.swift
//  OneLabHW5
//
//  Created by Mereke on 16.04.2023.
//

import Foundation
import Security

class KeychainHelper {

    // implement unit tests:
    static func saveToken(_ token: String) -> Bool {
        guard let data = token.data(using: .utf8) else {
            return false
        }

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "myapp_token",
            kSecValueData: data
        ] as CFDictionary

        let status = SecItemAdd(query, nil)
        return status == errSecSuccess
    }

    static func getToken() -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "myapp_token",
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        guard status == errSecSuccess,
            let item = result as? [String: Any],
            let tokenData = item[kSecValueData as String] as? Data,
            let token = String(data: tokenData, encoding: .utf8)
        else {
            return nil
        }

        return token
    }

    static func deleteToken() -> Bool {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "myapp_token"
        ] as CFDictionary

        let status = SecItemDelete(query)
        return status == errSecSuccess
    }
}
