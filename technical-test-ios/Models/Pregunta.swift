//
//  Pregunta.swift
//  technical-test-ios
//
//  Created by Luis Segoviano on 04/08/25.
//

import Foundation

struct Pregunta: Codable, Identifiable {
    var id: String { pregunta }
    let pregunta: String
    let values: [Valor]
}
