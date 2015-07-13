
//
//  Test.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 13.07.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol TestProtocol {
    static func test1()
    static func test2()
}

public struct TestClass : TestProtocol {
    public static func test1() { print("test1") }
    public static func test2() { print("test2") }
}

public protocol DatastructureProtocol {
    typealias ElementType: TestProtocol
}

public extension DatastructureProtocol {
    public func doSomething() {
        ElementType.test1()
        ElementType.test2()
    }
}

public struct Datastructure<T: TestProtocol> : DatastructureProtocol {
    public typealias ElementType = T
    
    public init() {}
}