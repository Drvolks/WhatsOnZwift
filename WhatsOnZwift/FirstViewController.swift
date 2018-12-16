//
//  FirstViewController.swift
//  WhatsOnZwift
//
//  Created by $(AUTHOR) on 2018-11-12.
//  Copyright © 2018 $(ORGANIZATION_NAME). All rights reserved.
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
        
        map.text = AppointmentUtils.getName(appointment: currentAppointment)
        map.font = map.font.with(traits: [.traitBold, .traitItalic])
        mapImage.image = UIImage(named: currentAppointment.map.rawValue.lowercased())
    }
}

