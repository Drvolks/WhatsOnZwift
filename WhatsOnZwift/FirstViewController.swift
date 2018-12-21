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
    @IBOutlet weak var whatsOnZwift: UILabel!
    @IBOutlet weak var timeToNextMap: UILabel!
    var countdownTimer: Timer!
    var totalTime = 60
    var nextAppointment:Appointment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeToNextMap.isHidden = true
        
        let parser = ZwiftXmlParser()
        let appointments = parser.parse()
        let currentAppointment = AppointmentUtils.getCurrent(appointments: appointments)
        let nextAppointments = AppointmentUtils.getFutures(appointments: appointments)
        if(nextAppointments.count > 0) {
            nextAppointment = nextAppointments[0]
        }
        
        whatsOnZwift.font = whatsOnZwift.font.with(traits: [.traitBold, .traitItalic])
        timeToNextMap.font = timeToNextMap.font.with(traits: [.traitBold, .traitItalic])
        IOSFontHelper.setMapName(label: map, appointment: currentAppointment)
        mapImage.image = UIImage(named: currentAppointment.map.rawValue.lowercased())
        
        startTimer()
    }
    
    func startTimer() {
        if let appointment = nextAppointment {
            let targetDate = appointment.start
            timeToNextMap.isHidden = false

            let calendar = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: targetDate)
            let days = calendar.day!
            let hours = calendar.hour!
            let minutes = calendar.minute!
            let seconds = calendar.second!
            totalTime = hours * 60 * 60 + minutes * 60 + seconds
            totalTime = days * 60 * 60 * 24 + totalTime
            
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        } else {
            timeToNextMap.isHidden = true
        }
    }
    
    @objc func updateTime() {
        timeToNextMap.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        var map = ""
        if let appointment = nextAppointment {
            map = AppointmentUtils.getName(appointment: appointment)
        }
        
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let hours: Int = (totalSeconds / 60 / 60) % 24
        let days: Int = (totalSeconds / 60 / 60 / 24)
        
        let result:String
        
        if(days > 0) {
           result = String(format: "%dD %02dH %02dM %02dS", days, hours, minutes, seconds)
        } else {
            result = String(format: "%02dH %02dM %02dS", hours, minutes, seconds)
        }
        
        return map + " up next in " + result
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        timeToNextMap.isHidden = true
    }
}

