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
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Quando você quer acordar?")
                    .font(.headline)
                    .lineLimit(nil)
                
                DatePicker($wakeUp, displayedComponents: .hourAndMinute)
            }
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
