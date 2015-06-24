//
//  _ContactGridType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

protocol _ContactGridType /*: Hashable, Equatable, CollectionType, SequenceType, _CollectionDefaultsType, _CollectionGeneratorDefaultsType, MutableCollectionType, Sliceable, _Sliceable, __ArrayType, ArrayLiteralConvertible, MutableSliceable, Reflectable, CustomStringConvertible, CustomDebugStringConvertible*/ {
    
    // MARK: Associated types
    
    typealias Element: _ContactGridSegmentType
    typealias Index = (Int, Int)
    
    typealias Delegate: _ContactGridDelegate
    
    // MARK: Initializers
    
    init()
    init(minimumCapacity: Int)
    init<S : SequenceType where S.Generator.Element == Element>(_ sequence: S)
    
    // MARK: Instance variables
    
    var delegate: Delegate? { get set }
    
    // MARK: Instance methods
    
    func segmentAtPoint(point: Index) -> Element?
    
    mutating func insertAtPoint(point: Index)
    mutating func removeAtPoint(point: Index) -> Element?
    mutating func removeAll(keepCapacity keepCapacity: Bool)
    
    mutating func addPolygon(polygon: [CGPoint], withEffect: (Element -> ()), allowInsertingSegments: Bool)
}

// TODO: Default implementations

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension _ContactGridType {
    
    /// A textual representation of `self`.
    var description: String { return "TODO" }
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String { return "TODO" }
}
