//
//  Extensions.swift
//  WhatsOnZwift
//
//  Created by $(AUTHOR) on 2018-11-12.
//  Copyright © 2018 $(ORGANIZATION_NAME). All rights reserved.
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
