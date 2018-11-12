//
//  AppointmentUtilsTests.swift
//  WhatsOnZwiftTests
//
//  Created by Jean-Francois Dufour on 2018-11-12.
//  Copyright © 2018 Consultation Massawippi. All rights reserved.
//

import XCTest
@testable import WhatsOnZwift

class AppointmentUtilsTests: XCTestCase {
    var appointments = [Appointment]()
    var currentDate = Date()
    var parser = ZwiftXmlParser()
    var appointment = Appointment()
    
    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "MapScheduleUnsorted", ofType: "xml")!
        let xmlData = try! Data(contentsOf: URL(fileURLWithPath: path))
        parser = ZwiftXmlParser(xmlData: xmlData)
        appointments = parser.parse()
        currentDate = parser.parseDate(dateString: "2018-11-07T00:01-04")
    }
    
    func testSort() {
        let result = AppointmentUtils.sortAppointments(appointments: appointments)
        XCTAssertEqual(24, result.count)
        
        XCTAssertEqual(Map.WATOPIA, result[0].map)
        XCTAssertEqual("2018-10-01 04:01:00 +0000", result[0].start.description)
        
        XCTAssertEqual(Map.INNSBRUCK, result[23].map)
        XCTAssertEqual("2018-11-30 04:01:00 +0000", result[23].start.description)
    }
    
    func testGetCurrents() {
        let result = AppointmentUtils.getCurrents(currentDate: currentDate, appointments: appointments)
        XCTAssertEqual(11, result.count)
        
        XCTAssertEqual(Map.NEWYORK, result[0].map)
        XCTAssertEqual("2018-11-06 04:01:00 +0000", result[0].start.description)
        
        XCTAssertEqual(Map.LONDON, result[1].map)
        XCTAssertEqual("2018-11-08 04:01:00 +0000", result[1].start.description)
    }
    
    func testGetCurrents_no_result() {
        currentDate = parser.parseDate(dateString: "2019-11-07T00:01-04")
        let result = AppointmentUtils.getCurrents(currentDate: currentDate, appointments: appointments)
        XCTAssertEqual(0, result.count)
    }
    
    func testGetCurrent() {
        let result = AppointmentUtils.getCurrent(currentDate: currentDate, appointments: appointments)
        XCTAssertEqual(Map.NEWYORK, result.map)
        XCTAssertEqual("2018-11-06 04:01:00 +0000", result.start.description)
    }
    
    func testGetCurrent_no_result() {
        currentDate = parser.parseDate(dateString: "2019-11-07T00:01-04")
        let result = AppointmentUtils.getCurrent(currentDate: currentDate, appointments: appointments)
        XCTAssertEqual(Map.UNKNOWN, result.map)
    }
    
    func testGetFutures() {
        let result = AppointmentUtils.getFutures(currentDate: currentDate, appointments: appointments)
        XCTAssertEqual(10, result.count)
        
        XCTAssertEqual(Map.LONDON, result[0].map)
        XCTAssertEqual("2018-11-08 04:01:00 +0000", result[0].start.description)
    }
    
    func testGetFutures_no_result() {
        currentDate = parser.parseDate(dateString: "2019-11-07T00:01-04")
        let result = AppointmentUtils.getFutures(currentDate: currentDate, appointments: appointments)
        XCTAssertEqual(0, result.count)
    }
    
    func testGetName() {
        appointment.map = Map.NEWYORK
        var result = AppointmentUtils.getName(appointment: appointment)
        XCTAssertEqual("New York", result)
        
        appointment.map = Map.RICHMOND
        result = AppointmentUtils.getName(appointment: appointment)
        XCTAssertEqual("Richmond", result)
        
        appointment.map = Map.UNKNOWN
        result = AppointmentUtils.getName(appointment: appointment)
        XCTAssertEqual("", result)
    }
}
