//
//  Metadata.swift
//  Impeller
//
//  Created by Drew McCormack on 08/12/2016.
//  Copyright © 2016 Drew McCormack. All rights reserved.
//

import Foundation

public typealias UniqueIdentifier = String

/// Metadata for a repositable
public struct Metadata: Equatable {
    
    public enum Key: String {
        case uniqueIdentifier, commitIdentifier, isDeleted, timestampsByPropertyName
    }
        
    public let uniqueIdentifier: UniqueIdentifier
    public internal(set) var commitIdentifier: CommitIdentifier?
    public internal(set) var isDeleted: Bool
    public var timestampsByPropertyName = [String:TimeInterval]()
    
    public init(uniqueIdentifier: UniqueIdentifier = UUID().uuidString) {
        self.uniqueIdentifier = uniqueIdentifier
        self.isDeleted = false
    }
        
    public static func == (left: Metadata, right: Metadata) -> Bool {
        return left.uniqueIdentifier == right.uniqueIdentifier && left.commitIdentifier == right.commitIdentifier && left.isDeleted == right.isDeleted && left.timestampsByPropertyName == right.timestampsByPropertyName
    }
    
}
