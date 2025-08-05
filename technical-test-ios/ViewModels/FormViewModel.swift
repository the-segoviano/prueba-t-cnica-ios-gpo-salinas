
import Foundation
import FirebaseFirestore
import UIKit
import Combine

class FormViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSuccess = false
    
    @Published var lastProfile: Profile?
    
    private var db = Firestore.firestore()
    
    func fetchLastProfile() {
        db.collection("profiles")
          .order(by: "createdAt", descending: true)
          .limit(to: 1)
          .getDocuments { [weak self] (snapshot, error) in
              if let error = error {
                  self?.errorMessage = "Error al obtener el último perfil: \(error.localizedDescription)"
                  return
              }

              // Asegurarse de que hay un documento
              guard let document = snapshot?.documents.first else {
                  self?.lastProfile = nil // No hay perfiles guardados
                  return
              }

              let data = document.data()
              let id = document.documentID
              let name = data["fullName"] as? String ?? "Sin nombre"
              
              // Decodificar la imagen desde Base64
              if let imageBase64 = data["imageBase64"] as? String,
                 let imageData = Data(base64Encoded: imageBase64),
                 let image = UIImage(data: imageData) {
                  
                  DispatchQueue.main.async {
                      self?.lastProfile = Profile(id: id, fullName: name, image: image)
                  }
              }
          }
    }
    
    func saveData(name: String, image: UIImage?) {
        guard !name.isEmpty, let image = image else {
            self.errorMessage = "Por favor, complete todos los campos."
            return
        }
        
        // Convertir la imagen a una cadena Base64
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            self.errorMessage = "No se pudo procesar la imagen."
            return
        }
        
        if imageData.count > 1_048_576 { // Límite de 1MB de Firestore
            self.errorMessage = "La imagen es demasiado grande para guardarla (máx 1MB)."
            return
        }
        
        let imageBase64String = imageData.base64EncodedString()
        
        isLoading = true
        
        // Guardar los datos en Firestore
        saveProfile(name: name, imageBase64: imageBase64String)
    }
    
    private func saveProfile(name: String, imageBase64: String) {
        let profileData: [String: Any] = [
            "fullName": name,
            "imageBase64": imageBase64,
            "createdAt": Timestamp(date: Date())
        ]
        
        db.collection("profiles").addDocument(data: profileData) { [weak self] error in
            self?.isLoading = false
            if let error = error {
                self?.errorMessage = "Error al guardar los datos: \(error.localizedDescription)"
            } else {
                self?.isSuccess = true
            }
        }
    }
}
