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
    @IBOutlet weak var upNextLabel: WKInterfaceLabel!
    var countdownTimer: Timer!
    var totalTime = 60
    var nextAppointment:Appointment?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        
        upNextLabel.setHidden(true)
        nextLabel.setHidden(true)
        map.setText("Loading...")
        
        nextLabel.setHeight(CGFloat(50))
        
        let url = URL(string:ZwiftXmlParser.urlString)!
        var request = URLRequest(url: url)
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        URLSession.shared.dataTask(with: request) { (data, res, error) -> Void in
            if error != nil {
                print("dataTaskWithURL fail")
                return
            }
            if let data = data {
                let parser = ZwiftXmlParser(xmlData: data)
                let appointments = parser.parse()
                let currentAppointment = AppointmentUtils.getCurrent(appointments: appointments)
                let futureAppointments = AppointmentUtils.getFutures(appointments: appointments)
                if(futureAppointments.count > 0) {
                    self.nextAppointment = futureAppointments[0]
                    self.startTimer()
                }
                
                WatchFontHelper.setMapText(label: self.map, appointment: currentAppointment)
                
                self.mapImage.setImage(UIImage(named: currentAppointment.map.rawValue.lowercased()))
                
                self.nextLabel.setHidden(false)
                
                self.futureTable.setNumberOfRows(futureAppointments.count, withRowType: "appointmentRow")
                
                for index in 0..<self.futureTable.numberOfRows {
                    guard let controller = self.futureTable.rowController(at: index) as? AppointmentRowController else { continue }
                    controller.fromAppointment(appointment: futureAppointments[index])
                }
            }
            }.resume()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }

    func startTimer() {
        if let appointment = nextAppointment {
            totalTime = AppointmentUtils.timeToNext(appointment: appointment, currentDate:Date())
            
            DispatchQueue.main.async {
                self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
            }
        }
    }
    
    @objc func updateTime() {
        upNextLabel.setHidden(false)
        upNextLabel.setText("\(timeFormatted(totalTime))")
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        if let appointment = nextAppointment {
            let map = AppointmentUtils.getName(appointment: appointment)
            let timeToText = AppointmentUtils.timeToText(totalSeconds)
            return map + " up next\n" + timeToText
        }
        
        return ""
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        upNextLabel.setHidden(true)
    }
}
