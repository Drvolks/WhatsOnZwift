//
//  IOSFontHelper.swift
//  WhatsOnZwift
//
//  Created by $(AUTHOR) on 2018-12-16.
//  Copyright © 2018 $(ORGANIZATION_NAME). All rights reserved.
//

import Foundation
import UIKit

class IOSFontHelper {
    static func setMapName(label: UILabel, appointment: Appointment) {
        label.text = AppointmentUtils.getName(appointment: appointment)
        label.font = label.font.with(traits: [.traitBold, .traitItalic])
    }
}
