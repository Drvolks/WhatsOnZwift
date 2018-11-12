import Foundation
import UIKit

class IOSFontHelper {
    static func setMapName(label: UILabel, appointment: Appointment) {
        label.text = AppointmentUtils.getName(appointment: appointment)
        label.font = label.font.with(traits: [.traitBold, .traitItalic])
    }
}
