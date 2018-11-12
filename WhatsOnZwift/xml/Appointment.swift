//
//  Appointment.swift
//  WhatsOnZwift
//
//  Created by Jean-Francois Dufour on 2018-11-12.
//  Copyright © 2018 Consultation Massawippi. All rights reserved.
//

import Foundation

class Appointment {
    var map = Map.UNKNOWN
    var start:Date
    
    init() {
        var dateComponents = DateComponents()
        dateComponents.year = 1980
        dateComponents.month = 1
        dateComponents.day = 1
        
        let userCalendar = Calendar.current
        start = userCalendar.date(from: dateComponents)!
    }
}
