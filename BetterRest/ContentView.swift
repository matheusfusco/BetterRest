//
//  ContentView.swift
//  BetterRest
//
//  Created by Matheus Pacheco Fusco on 18/06/19.
//  Copyright © 2019 Matheus Pacheco Fusco. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount: Double = 8
    @State private var coffeeAmount: Int = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Quando você quer acordar?")
                    .font(.headline)
                    .lineLimit(nil)
                
                DatePicker($wakeUp, displayedComponents: .hourAndMinute)
                
                Text("Quantidade desejada de sono")
                    .font(.headline)
                    .lineLimit(nil)
                
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") horas")
                }.padding(.bottom)
                
                Text("Quantidade desejada de sono")
                    .font(.headline)
                    .lineLimit(nil)
                
                Stepper(value: $coffeeAmount, in: 1...20, step: 1) {
                    if coffeeAmount == 1 {
                        Text("1 xícara")
                    } else {
                        Text("\(coffeeAmount) xícaras")
                    }
                }
                
                Spacer()
            }
                .navigationBarTitle(Text("Better Rest"))
                .navigationBarItems(trailing:
                    Button(action: calculateBedTime) {
                    Text("Calcular")
                })
                .padding()
                .presentation($showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
                }
        }
    }
    
    func calculateBedTime() {
        let model = SleepCalculator()
        
        do {
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(coffee: Double(coffeeAmount), estimatedSleep: sleepAmount, wake: Double(hour * minute))
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            let sleepTime = wakeUp - prediction.actualSleep
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Sua hora ideal de ir para a cama é..."
        } catch {
            alertTitle = "Erro"
            alertMessage = "Desculpe, houve um problema para calcular o tempo de sono."
        }
        
        showingAlert = true
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
