//
//  AppointmentCell.swift
//  WhatsOnZwift
//
//  Created by $(AUTHOR) on 2018-11-12.
//  Copyright © 2018 $(ORGANIZATION_NAME). All rights reserved.
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
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy HH:mm"
            startDate.text = formatter.string(from: appointment.start)
        } else {
            startDate.text = ""
        }
    }
}
