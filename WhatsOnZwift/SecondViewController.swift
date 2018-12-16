//
//  SecondViewController.swift
//  WhatsOnZwift
//
//  Created by Jean-Francois Dufour on 2018-11-12.
//  Copyright © 2018 Consultation Massawippi. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController {
    
    var futurAppointments = [Appointment]()
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parser = ZwiftXmlParser()
        let appointments = parser.parse()
        futurAppointments = AppointmentUtils.getFutures(appointments: appointments)
        
        table.backgroundColor = UIColor(rgb: 0x4EB0C9)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return futurAppointments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "appointment", for: indexPath) as? AppointmentCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let appointment = futurAppointments[indexPath.row]
        cell.fromAppointment(appointment: appointment)
        
        return cell
    }
}

