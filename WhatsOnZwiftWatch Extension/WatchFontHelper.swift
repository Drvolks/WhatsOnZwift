//
//  WatchFontHelper.swift
//  WhatsOnZwiftWatch Extension
//
//  Created by Jean-Francois Dufour on 2018-12-16.
//  Copyright © 2018 Consultation Massawippi. All rights reserved.
//

import Foundation
import WatchKit

class WatchFontHelper {
    static func setMapText(label: WKInterfaceLabel, appointment: Appointment) {
        let font = UIFont.systemFont(ofSize: 36.0).with(traits: [.traitBold, .traitItalic])
        let attrStr = NSAttributedString(string: AppointmentUtils.getName(appointment: appointment), attributes: [NSAttributedString.Key.font: font])
        label.setAttributedText(attrStr)
    }
}
