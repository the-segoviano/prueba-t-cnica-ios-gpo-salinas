//
//  ContentView.swift
//  technical-test-ios
//
//  Created by Luis Segoviano on 04/08/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userName: String = ""
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingCamera = false
    @State private var showingActionSheet = false
    @State private var showingGraphs = false
    
    // Colores personalizados
    let primaryColor = Color(hex: "4B0082") // Índigo
    let secondaryColor = Color(hex: "1E3A8A") // Azul oscuro (interpretando L3546 como un azul)
    
    @StateObject private var viewModel = ColorViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 0) {
                // Header con gradiente
                VStack {
                    Text("Formulario de Inicio")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [primaryColor, secondaryColor]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                
                // Formulario
                ScrollView {
                    VStack(spacing: 16) {
                        // Celda 1: TextField para nombre
                        FormCell {
                            VStack(alignment: .leading, spacing: 8) {
                                Label("Nombre completo", systemImage: "person.fill")
                                    .font(.headline)
                                    .foregroundColor(primaryColor)
                                
                                TextField("Ingrese su nombre", text: $userName)
                                    .textFieldStyle(CustomTextFieldStyle())
                                    .onChange(of: userName) { newValue in
                                        // Filtrar solo caracteres alfabéticos y espacios
                                        let filtered = newValue.filter { $0.isLetter || $0.isWhitespace }
                                        if filtered != newValue {
                                            userName = filtered
                                        }
                                    }
                                
                                if !userName.isEmpty {
                                    HStack {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                        Text("Nombre válido")
                                            .font(.caption)
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                        }
                        
                        // Celda 2: Selfie
                        FormCell {
                            VStack(alignment: .leading, spacing: 12) {
                                Label("Fotografía", systemImage: "camera.fill")
                                    .font(.headline)
                                    .foregroundColor(primaryColor)
                                
                                Button(action: {
                                    if selectedImage != nil {
                                        showingActionSheet = true
                                    } else {
                                        showingCamera = true
                                    }
                                }) {
                                    if let image = selectedImage {
                                        // Mostrar imagen seleccionada
                                        VStack(spacing: 8) {
                                            Image(uiImage: image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 120, height: 120)
                                                .clipShape(Circle())
                                                .overlay(
                                                    Circle()
                                                        .stroke(primaryColor, lineWidth: 3)
                                                )
                                            
                                            Text("Toca para cambiar")
                                                .font(.caption)
                                                .foregroundColor(secondaryColor)
                                        }
                                    } else {
                                        // Placeholder para tomar foto
                                        VStack(spacing: 12) {
                                            ZStack {
                                                Circle()
                                                    .fill(Color.gray.opacity(0.2))
                                                    .frame(width: 120, height: 120)
                                                
                                                VStack {
                                                    Image(systemName: "camera.fill")
                                                        .font(.system(size: 30))
                                                        .foregroundColor(primaryColor)
                                                    Text("Tomar selfie")
                                                        .font(.caption)
                                                        .foregroundColor(secondaryColor)
                                                }
                                            }
                                        }
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                        // Celda 3: Botón Gráficas
                        FormCell {
                            Button(action: {
                                showingGraphs = true
                            }) {
                                HStack {
                                    Image(systemName: "chart.bar.fill")
                                        .font(.title2)
                                    Text("Gráficas")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                }
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [primaryColor, secondaryColor]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(12)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
                // viewModel.backgroundColor.color.ignoresSafeArea()
                .background( Color(.systemGroupedBackground) )
            }
            .navigationBarHidden(true)
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(
                title: Text("Opciones de fotografía"),
                buttons: [
                    .default(Text("Ver foto actual")) {
                        // Aquí podrías mostrar la foto en pantalla completa
                    },
                    .default(Text("Tomar nueva foto")) {
                        showingCamera = true
                    },
                    .default(Text("Seleccionar de galería")) {
                        showingImagePicker = true
                    },
                    .cancel(Text("Cancelar"))
                ]
            )
        }
        .sheet(isPresented: $showingCamera) {
            ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
        }
        .sheet(isPresented: $showingGraphs) {
            GraphsView()
        }
        
    }
}

#Preview {
    ContentView()
}
