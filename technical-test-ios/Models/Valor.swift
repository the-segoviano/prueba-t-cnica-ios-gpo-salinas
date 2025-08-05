//
//  Valor.swift
//  technical-test-ios
//
//  Created by Luis Segoviano on 04/08/25.
//

import Foundation

struct Valor: Codable, Identifiable {
    var id: String { label }
    let label: String
    let value: Double
}
