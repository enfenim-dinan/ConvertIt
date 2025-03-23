//
//  ContentView.swift
//  ConvertIt
//
//  Created by Anastasiia Kotova on 23.03.25.
//

import SwiftUI

struct ContentView: View {
    @State var targetInput: Double? = 0.0
    @State var unitType: String = UnitTypes.temperature.rawValue
    @State var fromMeasurmentType: String = Temperature.celsius.rawValue
    @State var toMeasurmentType: String = Temperature.fahrenheit.rawValue
    @FocusState var inputIsSelected: Bool
    
    var result: Double {
            fromCommonMeasure(commonMeasure: toCommonMeasure())
        }
    
    var body: some View {
        NavigationView {
                Form {
                    Section("Choose conversion type") {
                        Picker("Choose conversion type", selection: $unitType) {
                            ForEach(UnitTypes.allCases, id: \.rawValue) {
                                Text($0.rawValue).tag($0)
                            }
                        }.pickerStyle(.segmented)
                            .onChange(of: unitType, updateMeasurementTypes)
                        // probablu better not reset input
//                            .onChange(of: unitType) {
//                                targetInput = 0.0
//                            }
                    }
                    
                    Section("From") {
                        TextField("Enter value", value: $targetInput, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($inputIsSelected)
                        Picker("Choose measure", selection: $fromMeasurmentType) {
                            ForEach(getMeasurementList(), id: \.self) { measurement in
                                Text(measurement).tag(measurement)
                            }
                        }
                        
                    }
                    
                    Section("To") {
                        Picker("Choose measure", selection: $toMeasurmentType) {
                            ForEach(getMeasurementList(), id: \.self) { measurement in
                                Text(measurement).tag(measurement)
                            }
                        }
                        Text("\(result.clean)")
                    }
                    
                }.navigationTitle("Convert it")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack(spacing: 0) {
                                Text("Convert ")
                                Text("it")
                                    .foregroundColor(.red)
                            }
                            .font(.headline)
                        }
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            if inputIsSelected {
                                Button("Clear") {
                                    targetInput = nil
                                }
                                Button("Done") {
                                    if targetInput == nil {
                                        targetInput = 0.0
                                    }
                                    inputIsSelected = false
                                }
                            }
                        }
                    }
        }
    }
    
    func getMeasurementList() -> [String] {
        switch unitType {
        case UnitTypes.length.rawValue:
            return Length.allCases.map { $0.rawValue }
        case UnitTypes.time.rawValue:
            return Time.allCases.map { $0.rawValue }
        case UnitTypes.volume.rawValue:
            return Volume.allCases.map { $0.rawValue }
        default:
            return Temperature.allCases.map { $0.rawValue }
        }
    }
    
    func updateMeasurementTypes() {
        switch unitType {
        case UnitTypes.length.rawValue:
            fromMeasurmentType = Length.meters.rawValue
            toMeasurmentType = Length.kilometers.rawValue
        case UnitTypes.time.rawValue:
            fromMeasurmentType = Time.seconds.rawValue
            toMeasurmentType = Time.minutes.rawValue
        case UnitTypes.volume.rawValue:
            fromMeasurmentType = Volume.milliliters.rawValue
            toMeasurmentType = Volume.liters.rawValue
        default:
            fromMeasurmentType = Temperature.celsius.rawValue
            toMeasurmentType = Temperature.fahrenheit.rawValue
        }
    }
    // this two functions looks awful, wish to have better solution for this
    func toCommonMeasure() -> Double {
        let input = targetInput ?? 0.0
        switch fromMeasurmentType {
        case Temperature.fahrenheit.rawValue:
            return (input - 32) * 5/9
        case Temperature.kelvin.rawValue:
            return input - 273.15
        case Length.kilometers.rawValue:
            return input * 1000
        case Length.feet.rawValue:
            return input * 0.3048
        case Length.yards.rawValue:
            return input * 0.9144
        case Length.miles.rawValue:
            return input * 1609.344
        case Time.minutes.rawValue:
            return input * 60
        case Time.hours.rawValue:
            return input * 60 * 60
        case Time.days.rawValue:
            return input * 60 * 60 * 24
        case Volume.liters.rawValue:
            return input * 1000
        case Volume.cups.rawValue:
            return input * 236.588
        case Volume.pints.rawValue:
            return input * 473.176473
        case Volume.gallons.rawValue:
            return input * 3785.41
        default:
            return input
        }
    }
    // omg, alredy hate these two big switches @@
    func fromCommonMeasure(commonMeasure: Double) -> Double {
        switch toMeasurmentType {
        case Temperature.fahrenheit.rawValue:
            return (commonMeasure * 9/5) + 32
        case Temperature.kelvin.rawValue:
            return commonMeasure + 273.15
        case Length.kilometers.rawValue:
            return commonMeasure / 1000
        case Length.feet.rawValue:
            return commonMeasure / 0.3048
        case Length.yards.rawValue:
            return commonMeasure / 0.9144
        case Length.miles.rawValue:
            return commonMeasure / 1609.344
        case Time.minutes.rawValue:
            return commonMeasure / 60
        case Time.hours.rawValue:
            return commonMeasure / 60 / 60
        case Time.days.rawValue:
            return commonMeasure / 60 / 60 / 24
        case Volume.liters.rawValue:
            return commonMeasure / 1000
        case Volume.cups.rawValue:
            return commonMeasure / 236.588
        case Volume.pints.rawValue:
            return commonMeasure / 473.176473
        case Volume.gallons.rawValue:
            return commonMeasure / 3785.41
        default:
            return commonMeasure
        }
    }
}

#Preview {
    ContentView()
}
