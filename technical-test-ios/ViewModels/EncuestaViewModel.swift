//
//  EncuestaViewModel.swift
//  technical-test-ios
//
//  Created by Luis Segoviano on 04/08/25.
//

import Foundation

class EncuestaViewModel: ObservableObject {
    
    @Published var preguntas: [Pregunta] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "test", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(Encuesta.self, from: data)
            self.preguntas = decoded.data
        } catch {
            print("Error al cargar el JSON: \(error)")
        }
    }
}
