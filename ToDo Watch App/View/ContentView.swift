//
//  ContentView.swift
//  ToDo Watch App
//
//  Created by Artur Balcer on 24/01/2023.
//

import SwiftUI


struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    
    @AppStorage("lineCount") var lineCount: Int = 1
    
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    
    // MARK: - FUNCTIONS
    
    func save() {
        do {
            print(notes)
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
        NavigationView {
            VStack {
                HStack(alignment: .center, spacing: 6) {
                    TextField("Dodaj wpis...", text: $text)
                    
                    Button {
                        if text.isEmpty {
                            return
                        }
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                        dateFormatter.locale = Locale(identifier: "pl_PL")
                        let dateString = dateFormatter.string(from: Date())
                        let note = Note(id: UUID(), text: text, date: dateString)
                        notes.append(note)
                        text = ""
                        save()
                    } label: {
                        Image(systemName: "plus.square.on.square").font(.system(size: 30, weight: .semibold))
                    }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.cyan)
                    //                .buttonStyle(BorderedButtonStyle(tint: .accentColor))
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)) // hstack
                Spacer()
                
                if notes.count >= 1 {
                    List {
                        ForEach(0..<notes.count, id: \.self) { i in
                            HStack {
                                NavigationLink(destination: NoteView(note: notes[i], count: notes.count, index: i))
                                {
                                    Capsule()
                                        .frame(width: 10)
                                        .foregroundColor(.cyan)
                                    Text(notes[i].text)
                                        .lineLimit(lineCount)
                                        .padding(.leading, 5)
                                }
                            }
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
            .onAppear(perform: {load() })
        }
        .navigationTitle("Notatnik")
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
