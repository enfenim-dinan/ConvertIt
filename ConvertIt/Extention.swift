//
//  Extention.swift
//  ConvertIt
//
//  Created by Anastasiia Kotova on 23.03.25.
//

import Foundation

extension Double {
    var clean: String {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", self)
        } else {
            return String(format: "%.3f", self)
        }
    }
}
