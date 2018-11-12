//
//  ZwiftXmlParserTests.swift
//  WhatsOnZwiftTests
//
//  Created by Jean-Francois Dufour on 2018-11-12.
//  Copyright © 2018 Consultation Massawippi. All rights reserved.
//

import XCTest
@testable import WhatsOnZwift

class ZwiftXmlParserTests: XCTestCase {
    var xmlData:Data?
    var parser = ZwiftXmlParser()
    
    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "MapSchedule", ofType: "xml")!
        xmlData = try! Data(contentsOf: URL(fileURLWithPath: path))
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConstructor() {
        let result = ZwiftXmlParser(xmlData: xmlData!)
        XCTAssertNotNil(result)
    }
    
    func testParseDate() {
        let result = parser.parseDate(dateString: "2018-10-01T00:01-04")
        XCTAssertEqual("2018-10-01 04:01:00 +0000", result.description)
    }
    
    func testParseMap() {
        var result = parser.parseMap(mapString: "WATOPIA")
        XCTAssertEqual(Map.WATOPIA, result)
        
        result = parser.parseMap(mapString: "TEST")
        XCTAssertEqual(Map.UNKNOWN, result)
    }

    func testParseAppointments() {
        parser = ZwiftXmlParser(xmlData: xmlData!)
        let result = parser.parse()
        XCTAssertEqual(24, result.count)
        
        XCTAssertEqual(Map.WATOPIA, result[0].map)
        XCTAssertEqual("2018-10-01 04:01:00 +0000", result[0].start.description)
        
        XCTAssertEqual(Map.INNSBRUCK, result[23].map)
        XCTAssertEqual("2018-11-30 04:01:00 +0000", result[23].start.description)
    }
    
    func testParseAppointments_live() {
        parser = ZwiftXmlParser()
        let result = parser.parse()
        XCTAssertTrue(result.count > 0)
        XCTAssertTrue(result[0].map != Map.UNKNOWN)
    }
}
