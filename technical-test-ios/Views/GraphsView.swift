//
//  GraphsView.swift
//  technical-test-ios
//
//  Created by Luis Segoviano on 04/08/25.
//

import SwiftUI
import Charts

struct GraphsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel = EncuestaViewModel()
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.preguntas) { pregunta in
                    PieChartView(pregunta: pregunta)
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    GraphsView()
}






struct PieChartView: View {
    
    let pregunta: Pregunta
    
    let colores: [Color] = [.mint, .red, .orange, .yellow, .blue, .purple, .gray]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(pregunta.pregunta)
                .font(.headline)
                .padding(.bottom, 4)
            
            ZStack {
                Chart {
                    ForEach(Array(pregunta.values.enumerated()), id: \.1.id) { index, value in
                        SectorMark(
                            angle: .value("Valor", value.value),
                            innerRadius: .ratio(0.6),
                            angularInset: 1
                        )
                        .foregroundStyle(colores[index % colores.count])
                    }
                }
                .frame(height: 200)
                
                // Círculo blanco para el "hueco" central
                Circle()
                    .fill(Color(.systemBackground))
                    .frame(width: 80, height: 80)
            }
            
            // Leyenda
            VStack(alignment: .leading, spacing: 4) {
                ForEach(Array(pregunta.values.enumerated()), id: \.1.id) { index, value in
                    HStack {
                        Circle()
                            .fill(colores[index % colores.count])
                            .frame(width: 12, height: 12)
                        Text("\(value.label) \(Int(value.value))%")
                            .font(.subheadline)
                    }
                }
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 1)
    }
}

