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
    
    @State private var isInfoPresented: Bool = false
    @State private var isSettingsPresented: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
         
            HeaderView(title: "")
            
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
                    .onTapGesture {
                        isSettingsPresented.toggle()
                    }
                    .sheet(isPresented: $isSettingsPresented, content: {
                        SettingsView()
                            .toolbar(content: {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Zamknij") {
                                        self.isSettingsPresented = false
                                    }
                                }
                            })
                    })
                
                
                Spacer()
                
                Text("\(index + 1) / \(count)")
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isInfoPresented.toggle()
                    }
                    .sheet(isPresented: $isInfoPresented, content: {
                        InfoView(date: note.date)
                            .toolbar(content: {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Zamknij") {
                                        self.isInfoPresented = false
                                    }
                                }
                            })
                    })
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: -25, trailing: 0))
            .foregroundColor(.secondary)
        }
        .padding(3)
    }
}

// MARK: - Preview

struct NoteView_Previews: PreviewProvider {
    static var sampleData: Note = Note(id: UUID(), text: "Przykladowy tekst", date: "20-01-2023")
    
    static var previews: some View {
        NoteView(note: sampleData, count: 5, index: 1)
    }
}
