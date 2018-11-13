//
//  InterfaceController.swift
//  WhatsOnZwiftWatch Extension
//
//  Created by Jean-Francois Dufour on 2018-11-12.
//  Copyright © 2018 Consultation Massawippi. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var map: WKInterfaceLabel!
    @IBOutlet weak var mapImage: WKInterfaceImage!
    @IBOutlet weak var futureTable: WKInterfaceTable!
    @IBOutlet weak var nextLabel: WKInterfaceLabel!
    
    var task: URLSessionDataTask?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        nextLabel.setHidden(true)
        map.setHidden(true)
        
        nextLabel.setHeight(CGFloat(50))
        
        let url = NSURL(string:ZwiftXmlParser.urlString)!
        let conf = URLSessionConfiguration.default
        let session = URLSession(configuration: conf)
        
        task = session.dataTask(with: url as URL) { (data, res, error) -> Void in
            if error != nil {
                print("dataTaskWithURL fail")
                return
            }
            if let data = data {
                let parser = ZwiftXmlParser(xmlData: data)
                let appointments = parser.parse()
                let currentAppointment = AppointmentUtils.getCurrent(appointments: appointments)
                let futureAppointments = AppointmentUtils.getFutures(appointments: appointments)
                
                self.map.setText(AppointmentUtils.getName(appointment: currentAppointment))
                self.mapImage.setImage(UIImage(named: currentAppointment.map.rawValue.lowercased()))
                
                self.map.setHidden(false)
                self.nextLabel.setHidden(false)
                
                self.futureTable.setNumberOfRows(futureAppointments.count, withRowType: "appointmentRow")
                
                for index in 0..<self.futureTable.numberOfRows {
                    guard let controller = self.futureTable.rowController(at: index) as? AppointmentRowController else { continue }
                    controller.fromAppointment(appointment: futureAppointments[index])
                }
            }
        }
    
        task!.resume()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }

}
