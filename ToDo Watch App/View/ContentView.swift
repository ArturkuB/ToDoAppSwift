//
//  ContentView.swift
//  ToDo Watch App
//
//  Created by Artur Balcer on 24/01/2023.
//

import SwiftUI


struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    
    // MARK: - FUNCTIONS
    
    func save() {
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("Failed to save")
        }
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                let url = getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                print("Failed to load")
            }
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    // MARK: - BODY
    
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                TextField("Dodaj wpis...", text: $text)
                
                Button {
                    if text.isEmpty {
                        return
                    }
                    let note = Note(id: UUID(), text: text)
                    notes.append(note)
                    text = ""
                    save()
                } label: {
                    Image(systemName: "plus.circle").font(.system(size: 42, weight: .semibold))
                }
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
                //                .buttonStyle(BorderedButtonStyle(tint: .accentColor))
            } // hstack
            Spacer()
            if notes.count >= 1 {
                List {
                    ForEach(0..<notes.count, id: \.self) { i in
                        HStack {
                            Capsule()
                                .frame(width: 10)
                                .foregroundColor(.accentColor)
                            Text(notes[i].text)
                                .lineLimit(1)
                                .padding(.leading, 5)
                        } // hstack
                    } // loop
                    .onDelete(perform: delete)
                } // list
            }
            else
            {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .opacity(0.25)
                    .padding(40)
                Spacer()
            }
            
        } // vstack
        .navigationTitle("Notatnik")
        .onAppear(perform: {load() })
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
