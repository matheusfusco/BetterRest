//
//  ContentView.swift
//  BetterRest
//
//  Created by Matheus Pacheco Fusco on 18/06/19.
//  Copyright © 2019 Matheus Pacheco Fusco. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @State private var wakeUp = Date()
    @State private var sleepAmount: Double = 8
    @State private var coffeeAmount: Int = 1
    
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
                .navigationBarItems(trailing: Button(action: {
                    
                }, label: {
                    Text("Calcular")
                }))
            .padding()
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
