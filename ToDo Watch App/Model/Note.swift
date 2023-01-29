//
//  Note.swift
//  ToDo Watch App
//
//  Created by Artur Balcer on 27/01/2023.
//

import Foundation

struct Note: Codable, Identifiable {
    let id: UUID
    let text: String
    let date: String
}
