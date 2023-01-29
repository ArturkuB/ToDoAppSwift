//
//  HeaderView.swift
//  ToDo Watch App
//
//  Created by Artur Balcer on 29/01/2023.
//

import SwiftUI

struct HeaderView: View {
    
    // MARK: - PROPERTY
    
    var title: String = ""
    var iconSysName: String = "pencil"
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            if title != "" {
                Text(title.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.cyan)
            }
            HStack {
                Capsule()
                    .frame(height: 1)
                Image(systemName: iconSysName)
                
                Capsule()
                    .frame(height: 1)
            }
            .foregroundColor(.cyan)
        } // vstack
    }
}

// MARK: - PREVIEW

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView(title: "Info")
            HeaderView()
        }
    }
}
