//
//  SettingsView.swift
//  ToDo Watch App
//
//  Created by Artur Balcer on 30/01/2023.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - PROPERTY
    
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var value: Float = 1.0
    
    // MARK: - FUNCTION
    
    func update() {
        lineCount = Int(value)
    }
    
    // MARK: - BODY
    
    var body: some View {
        VStack(spacing: 8) {
            HeaderView(title: "Ustawienia", iconSysName: "gearshape")
            
            Text("Wiersze: \(lineCount)".uppercased())
                .fontWeight(.bold)
            
            Slider(value: Binding(get: {
                self.value
            }, set: {(newValue) in
                self.value = newValue
                self.update()
            }), in: 1...4, step: 1)
                .accentColor(.cyan)
                .onAppear {
                    self.value = Float(self.lineCount)
                }
        } // vstack
    }
}

// MARK: - PREVIEW

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
