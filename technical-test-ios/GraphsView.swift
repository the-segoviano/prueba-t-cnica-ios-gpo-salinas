//
//  GraphsView.swift
//  technical-test-ios
//
//  Created by Luis Segoviano on 04/08/25.
//

import SwiftUI

struct GraphsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Gráficas")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Aquí se mostrarían las gráficas del usuario")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Gráficas")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Cerrar") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    GraphsView()
}
