//
//  XmlParser.swift
//  WhatsOnZwift
//
//  Created by Jean-Francois Dufour on 2018-11-12.
//  Copyright © 2018 Consultation Massawippi. All rights reserved.
//

import Foundation

class ZwiftXmlParser : XmlParserBase {
    static let urlString = "https://whatsonzwift.com/cached/MapSchedule.xml"
    static let appointmentElementName = "appointment"
    static let mapAttribute = "map"
    static let startAttribute = "start"
    static let dateFormat =  "yyyy-MM-dd'T'HH:mmX"

    var parser:XMLParser
    var appointments = [Appointment]()
    let dateFormatter = DateFormatter()
    
    override init() {
        let url = URL(string: ZwiftXmlParser.urlString)!
        parser = XMLParser(contentsOf: url)!
        
        super.init()
        initFormatter()
    }
    
    init(xmlData: Data) {
        parser = XMLParser(data: xmlData)
        
        super.init()
        initFormatter()
    }
    
    func initFormatter() {
        dateFormatter.dateFormat = ZwiftXmlParser.dateFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    }
    
    func parse() -> [Appointment] {
        parser.delegate = self
        parser.parse()
        
        return appointments
    }
    
    override func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        super.parser(parser, didStartElement: elementName, namespaceURI: namespaceURI, qualifiedName: qName, attributes: attributeDict)
        switch elementName {
        case ZwiftXmlParser.appointmentElementName:
            let appointment = Appointment()
            appointment.map = parseMap(mapString: currentAttributes[ZwiftXmlParser.mapAttribute]!)
            appointment.start = parseDate(dateString: currentAttributes[ZwiftXmlParser.startAttribute]!)
            
            appointments.append(appointment)
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
    
    func parseDate(dateString: String) -> Date {
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        return date
    }
    
    func parseMap(mapString : String) -> Map {
        return Map(rawValue: mapString) ?? Map.UNKNOWN
    }
}
