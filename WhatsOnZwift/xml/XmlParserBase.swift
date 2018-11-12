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

