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
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        nextLabel.setHeight(CGFloat(50))
        
        let parser = ZwiftXmlParser()
        let appointments = parser.parse()
        let currentAppointment = AppointmentUtils.getCurrent(appointments: appointments)
        let futureAppointments = AppointmentUtils.getFutures(appointments: appointments)
        
        map.setText(AppointmentUtils.getName(appointment: currentAppointment))
        mapImage.setImage(UIImage(named: currentAppointment.map.rawValue.lowercased()))
        
        futureTable.setNumberOfRows(futureAppointments.count, withRowType: "appointmentRow")
        
        for index in 0..<futureTable.numberOfRows {
            guard let controller = futureTable.rowController(at: index) as? AppointmentRowController else { continue }
            controller.fromAppointment(appointment: futureAppointments[index])
        }
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }

}
