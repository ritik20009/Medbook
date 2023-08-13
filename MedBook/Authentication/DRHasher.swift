//
//  DRHasher.swift
//  MedBook
//
//  Created by Ritik Raj on 13/08/23.
//

import CryptoKit

final class DRHasher {
    static func hash(_ string: String) -> String {
        guard let data = string.data(using: .utf8) else { return string }
        return SHA256.hash(data: data).compactMap { String(format: "%02x", $0) }.joined()
    }
}
