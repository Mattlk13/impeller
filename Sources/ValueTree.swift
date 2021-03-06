//
//  ValueTree.swift
//  Impeller
//
//  Created by Drew McCormack on 16/12/2016.
//  Copyright © 2016 Drew McCormack. All rights reserved.
//

public struct ValueTreeReference: Equatable, Hashable {
    let uniqueIdentifier: UniqueIdentifier
    let repositedType: RepositedType
    
    public var hashValue: Int {
        return uniqueIdentifier.hash ^ repositedType.hash
    }
    
    public static func ==(left: ValueTreeReference, right: ValueTreeReference) -> Bool {
        return left.uniqueIdentifier == right.uniqueIdentifier && left.repositedType == right.repositedType
    }
    
    public var asString: String {
        return "\(repositedType)__\(uniqueIdentifier)"
    }
}


public struct ValueTree: Equatable, Hashable {
    public var metadata: Metadata
    public var repositedType: RepositedType
    
    public internal(set) var propertiesByName = [String:Property]()
    
    public var valueTreeReference: ValueTreeReference {
        return ValueTreeReference(uniqueIdentifier: metadata.uniqueIdentifier, repositedType: repositedType)
    }
    
    public var propertyNames: [String] {
        return Array(propertiesByName.keys)
    }

    public init(repositedType: RepositedType, metadata: Metadata) {
        self.repositedType = repositedType
        self.metadata = metadata
    }
    
    public func get(_ propertyName: String) -> Property? {
        return propertiesByName[propertyName]
    }
    
    public mutating func set(_ propertyName: String, to property: Property) {
        propertiesByName[propertyName] = property
    }
    
    public var hashValue: Int {
        return metadata.uniqueIdentifier.hash
    }
    
    public static func ==(left: ValueTree, right: ValueTree) -> Bool {
        return left.repositedType == right.repositedType && left.metadata == right.metadata && left.propertiesByName == right.propertiesByName
    }
    
    func merged(with other: ValueTree?) -> ValueTree {
        guard let other = other, self != other else {
            return self
        }
        
        var mergedTree: ValueTree!
        if metadata.timestamp < other.metadata.timestamp {
            mergedTree = other
            mergedTree.metadata.version = max(other.metadata.version, metadata.version+1)
        }
        else {
            mergedTree = self
            mergedTree.metadata.version = max(metadata.version, other.metadata.version+1)
        }
        
        mergedTree.metadata.isDeleted = metadata.isDeleted || other.metadata.isDeleted
        
        return mergedTree
    }
}

