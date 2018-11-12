//
//  Extensions.swift
//  WhatsOnZwift
//
//  Created by Jean-Francois Dufour on 2018-11-12.
//  Copyright © 2018 Consultation Massawippi. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
