//
//  XmlParserBase.swift
//  WhatsOnZwift
//
//  Created by Jean-Francois Dufour on 2018-11-12.
//  Copyright © 2018 Consultation Massawippi. All rights reserved.
//

import Foundation

class XmlParserBase : NSObject, XMLParserDelegate {
    var currentElement = ""
    var foundCharacters = "";
    var currentAttributes:[String:String] = [:]
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        self.currentElement = elementName
        self.currentAttributes = attributeDict
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.foundCharacters += string
    }
}

