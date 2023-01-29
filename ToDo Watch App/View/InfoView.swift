//
//  InfoView.swift
//  ToDo Watch App
//
//  Created by Artur Balcer on 29/01/2023.
//

import SwiftUI

struct InfoView: View {
    
    // MARK: - PROPERTIES
    
    let date: String

    // MARK: - BODY
    
    var body: some View {
        VStack(spacing: 3) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
                .frame(height: 65)
                .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
            
            HeaderView(title: "Informacje", iconSysName: "note.text")
    
            Text("Artur B.")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            
            
            Text("Data utworzenia: \(date)")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)

            
        } // vstack
    }
}


// MARK: - Preview

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(date: "20-01-2023")
    }
}
