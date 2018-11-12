//
//  AppointmentCell.swift
//  WhatsOnZwift
//
//  Created by Jean-Francois Dufour on 2018-11-12.
//  Copyright © 2018 Consultation Massawippi. All rights reserved.
//

import UIKit

class AppointmentCell: UITableViewCell {
    
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var map: UILabel!
    
    func fromAppointment(appointment: Appointment) {
        map.text = AppointmentUtils.getName(appointment: appointment)
        mapImage.image = UIImage(named: appointment.map.rawValue.lowercased())
        
        if appointment.map != Map.UNKNOWN {
            let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
            let currentMonth = (calendar?.component(NSCalendar.Unit.month, from: appointment.start))!
            let currentYear = (calendar?.component(NSCalendar.Unit.year, from: appointment.start))!
            let currentDay = (calendar?.component(NSCalendar.Unit.day, from: appointment.start))!
            
            startDate.text = String(currentDay) + "-" + String(currentMonth) + "-" + String(currentYear)
        } else {
            startDate.text = ""
        }
    }
}
