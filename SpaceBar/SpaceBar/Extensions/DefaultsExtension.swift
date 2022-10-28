//
//  DefaultsExtension.swift
//  SpaceBar
//
//  Created by Pavel Makhov on 2022-10-08.
//

import Foundation
import Defaults
import KeychainAccess

extension Defaults.Keys {
 
    static let orgName = Key<String>("orgName", default: "")
    static let token = Key<String>("token", default: "")
    static let projectId = Key<String>("projectId", default: "")
}

extension KeychainKeys {
    static let token: KeychainAccessKey = KeychainAccessKey(key: "token")
}
