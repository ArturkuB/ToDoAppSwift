//
//  NoteView.swift
//  ToDo Watch App
//
//  Created by Artur Balcer on 27/01/2023.
//

import SwiftUI

struct NoteView: View {
    
    // MARK: - PROPERTIES
    
    let note: Note
    let count: Int
    let index: Int
    
    // MARK: - BODY
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            HStack {
                Capsule()
                    .frame(height: 1)
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            }
            .foregroundColor(.cyan)
            
            Spacer()
            
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                
                Spacer()
                
                Text("\(count) / \(index + 1)")
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: -25, trailing: 0))
            .foregroundColor(.secondary)
        }
        .padding(3)
    }
}

// MARK: - Preview

struct NoteView_Previews: PreviewProvider {
    static var sampleData: Note = Note(id: UUID(), text: "Przykladowy tekst")
    
    static var previews: some View {
        NoteView(note: sampleData, count: 5, index: 1)
    }
}
