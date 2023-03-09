//
//  ContentView.swift
//  TemperatureConversion
//
//  Created by Andrea on 04/03/2023.
//

import SwiftUI


enum Units: String  {
    case Celsius
    case Fahrenheit
    case Kelvin
}

struct ContentView: View {
    @State private var amount = 0.0
    @State private var unitSelected = Units.Celsius
    @State private var unitToConvert = Units.Celsius
    
    
    var units = [Units.Celsius, Units.Fahrenheit, Units.Kelvin]
    
    
    var convertedAmount :Double {
        if unitSelected == unitToConvert {
            return amount
        }
        
        var amountToConvert = amount
        
        if unitSelected == Units.Kelvin {
            amountToConvert = amount - 273.15
        }
        
        if unitSelected == Units.Fahrenheit {
            amountToConvert = (amount - 32) / 1.8
        }
        
        return convertCelsiusToOtherUnit(amount: amountToConvert)
        
    }
    
    func convertCelsiusToOtherUnit(amount:Double) -> Double{
        if unitToConvert == Units.Fahrenheit {
            print(amount)
            return amount * 1.8 + 32
        }
        
        if unitToConvert == Units.Kelvin {
            return amount + 273.15
        }
        
        return amount
    }

    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $amount, format:.number)
                        .keyboardType(.decimalPad)
                    
                    Picker("Unit", selection: $unitSelected){
                        ForEach(units, id: \.self){
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Amount to convert")
                }
                
                
                Section{
                    Picker("Unit", selection: $unitToConvert){
                        ForEach(units, id: \.self){
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                    
                    Text(convertedAmount, format: .number)
                } header: {
                    Text("Converted Amount")
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
