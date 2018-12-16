//
//  IOSFontHelper.swift
//  WhatsOnZwift
//
//  Created by Jean-Francois Dufour on 2018-12-16.
//  Copyright © 2018 Consultation Massawippi. All rights reserved.
//

import Foundation
import UIKit

class IOSFontHelper {
    static func setMapName(label: UILabel, appointment: Appointment) {
        label.text = AppointmentUtils.getName(appointment: appointment)
        label.font = label.font.with(traits: [.traitBold, .traitItalic])
    }
}
