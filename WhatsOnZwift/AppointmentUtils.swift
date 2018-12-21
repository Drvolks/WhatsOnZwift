//
//  AppointmentUtils.swift
//  WhatsOnZwift
//
//  Created by Jean-Francois Dufour on 2018-11-12.
//  Copyright © 2018 Consultation Massawippi. All rights reserved.
//

import Foundation

class AppointmentUtils {
    static func sortAppointments(appointments:[Appointment]) -> [Appointment] {
        return appointments.sorted(by: { $0.start.compare($1.start) == ComparisonResult.orderedAscending})
    }
    
    static func getCurrent(appointments:[Appointment]) -> Appointment {
        return getCurrent(currentDate: Date(), appointments:appointments)
    }
    
    static func getCurrent(currentDate:Date, appointments:[Appointment]) -> Appointment {
        let currentAppointments = getCurrents(currentDate: currentDate, appointments: appointments)
        if currentAppointments.isEmpty {
            return Appointment()
        }
        
        return currentAppointments[0]
    }
    
    static func getCurrents(appointments:[Appointment]) -> [Appointment] {
        return getCurrents(currentDate: Date(), appointments:appointments)
    }
    
    static func getCurrents(currentDate:Date, appointments:[Appointment]) -> [Appointment] {
        let currentsSorted = sortAppointments(appointments: appointments)
        var currents = [Appointment]()
        
        for index in 0..<currentsSorted.count {
            let currentAppointment = currentsSorted[index]
            
            if index != appointments.count-1 {
                let nextAppointment = currentsSorted[index+1]
            
                if currentAppointment.start.compare(currentDate).rawValue <= 0 &&
                    nextAppointment.start.compare(currentDate).rawValue > 0 {
                    currents.append(currentAppointment)
                }
            }
            
            if currentAppointment.start.compare(currentDate).rawValue > 0 {
                currents.append(currentAppointment)
            }
        }
        
        return currents
    }
    
    static func getFutures(appointments:[Appointment]) -> [Appointment] {
        return getFutures(currentDate: Date(), appointments:appointments)
    }
    
    static func getFutures(currentDate:Date, appointments:[Appointment]) -> [Appointment] {
        var currentAppointments = getCurrents(currentDate: currentDate, appointments: appointments)
        if !currentAppointments.isEmpty {
            currentAppointments.remove(at: 0)
        }
        return currentAppointments
    }
    
    static func getName(appointment: Appointment) -> String {
        switch appointment.map {
        case .NEWYORK:
            return "New York"
        case .UNKNOWN:
            return ""
        default:
            return appointment.map.rawValue.capitalizingFirstLetter()
        }
    }
    
    static func timeToNext(appointment:Appointment, currentDate:Date) -> Int {
        let targetDate = appointment.start
        
        let calendar = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: targetDate)
        let days = calendar.day!
        let hours = calendar.hour!
        let minutes = calendar.minute!
        let seconds = calendar.second!
        var totalTime = hours * 60 * 60 + minutes * 60 + seconds
        totalTime = days * 60 * 60 * 24 + totalTime
        
        return totalTime
    }
    
    static func timeToText(_ totalSeconds: Int) -> String {
        if totalSeconds < 0 {
            return ""
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
        
        return result
    }
}
