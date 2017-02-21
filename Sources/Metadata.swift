//
//  Metadata.swift
//  Impeller
//
//  Created by Drew McCormack on 08/12/2016.
//  Copyright © 2016 Drew McCormack. All rights reserved.
//

import Foundation


public typealias UniqueIdentifier = String
typealias RepositedVersion = String


/// Metadata for a repositable
public struct Metadata: Equatable {
    
    public enum Key: String {
        case version, timestamp, uniqueIdentifier, isDeleted
    }
        
    public let uniqueIdentifier: UniqueIdentifier
    public internal(set) var commitTimestamp: TimeInterval
    public internal(set) var isDeleted: Bool
    internal var version: RepositedVersion = UUID().uuidString
    public var timestampsByPropertyName = [String:TimeInterval]()
    
    public init(uniqueIdentifier: UniqueIdentifier = UUID().uuidString) {
        self.uniqueIdentifier = uniqueIdentifier
        self.commitTimestamp = Date.timeIntervalSinceReferenceDate
        self.isDeleted = false
    }
    
    public mutating func generateVersion() {
        version = UUID().uuidString
    }
        
    public static func == (left: Metadata, right: Metadata) -> Bool {
        return left.version == right.version && left.commitTimestamp == right.commitTimestamp && left.uniqueIdentifier == right.uniqueIdentifier && left.isDeleted == right.isDeleted
    }
    
}
