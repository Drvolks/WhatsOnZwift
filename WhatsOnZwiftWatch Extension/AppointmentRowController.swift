//
//  AppointmentRowController.swift
//  WhatsOnZwiftWatch Extension
//
//  Created by Jean-Francois Dufour on 2018-11-12.
//  Copyright © 2018 Consultation Massawippi. All rights reserved.
//

import Foundation
import WatchKit

class AppointmentRowController : NSObject {
    @IBOutlet weak var mapImage: WKInterfaceImage!
    @IBOutlet weak var startDate: WKInterfaceLabel!
    @IBOutlet weak var map: WKInterfaceLabel!
    
    func fromAppointment(appointment: Appointment) {
        map.setText(AppointmentUtils.getName(appointment: appointment))
        mapImage.setImage(UIImage(named: appointment.map.rawValue.lowercased()))
        
        if appointment.map != Map.UNKNOWN {
            let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
            let currentMonth = (calendar?.component(NSCalendar.Unit.month, from: appointment.start))!
            let currentYear = (calendar?.component(NSCalendar.Unit.year, from: appointment.start))!
            let currentDay = (calendar?.component(NSCalendar.Unit.day, from: appointment.start))!
            
            startDate.setText(String(currentDay) + "-" + String(currentMonth) + "-" + String(currentYear))
        } else {
            startDate.setText("")
        }
    }
}
