//
//  Units.swift
//  ConvertIt
//
//  Created by Anastasiia Kotova on 23.03.25.
//

import Foundation

enum UnitTypes: String, CaseIterable {
    case temperature = "🌡️"
    case length = "📏"
    case time = "⏱️"
    case volume = "💧"
}

protocol Measurments {
}

enum Temperature: String, CaseIterable, Measurments {
    case celsius = "celsius"
    case fahrenheit = "fahrenheit"
    case kelvin = "kelvin"
}

enum Length: String, CaseIterable, Measurments {
    case meters = "meters"
    case kilometers = "kilometers"
    case feet = "feet"
    case yards = "yards"
    case miles = "miles"
}

enum Time: String, CaseIterable, Measurments {
    case seconds = "seconds"
    case minutes = "minutes"
    case hours = "hours"
    case days = "days"
}

enum Volume: String, CaseIterable, Measurments {
    case milliliters = "milliliters"
    case liters = "liters"
    case cups = "cups"
    case pints = "pints"
    case gallons = "gallons"
}
