//
//  FirstViewController.swift
//  WhatsOnZwift
//
//  Created by Jean-Francois Dufour on 2018-11-12.
//  Copyright © 2018 Consultation Massawippi. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var map: UILabel!
    @IBOutlet weak var mapImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parser = ZwiftXmlParser()
        let appointments = parser.parse()
        let currentAppointment = AppointmentUtils.getCurrent(appointments: appointments)
        
        IOSFontHelper.setMapName(label: map, appointment: currentAppointment)
        mapImage.image = UIImage(named: currentAppointment.map.rawValue.lowercased())
    }
}

