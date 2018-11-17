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
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM HH:mm"
            startDate.setText(formatter.string(from: appointment.start))
        } else {
            startDate.setText("")
        }
    }
}
