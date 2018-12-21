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
            totalTime = AppointmentUtils.timeToNext(appointment: appointment, currentDate:Date())
            
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateTime() {
        if timeToNextMap.isHidden {
            timeToNextMap.isHidden = false
        }
        
        timeToNextMap.text = "\(timeFormatted(totalTime))"
        
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
            return map + " up next in " + timeToText
        }
        
        return ""
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        timeToNextMap.isHidden = true
    }
}

