//
//  _ContactGridDelegateType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

protocol _ContactGridDelegateType {
    
    // MARK: Associated types
    
    typealias Segment: _ContactGridSegmentType
    
    // MARK: Instance methods
    
    func didBeginResolveContacts()
    func didResolveContactInSegment(segment: Segment)
    func didEndResolveContacts()
}
