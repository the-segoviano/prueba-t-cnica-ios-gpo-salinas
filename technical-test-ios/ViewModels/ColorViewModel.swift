//
//  ColorViewModel.swift
//  technical-test-ios
//
//  Created by Luis Segoviano on 04/08/25.
//

import Foundation
import Combine
import FirebaseDatabase

class ColorViewModel: ObservableObject {
    @Published var backgroundColor: AppColor = AppColor(hex: "#FFFFFF", name: "Default") // Color por defecto
    
    private var ref: DatabaseReference = Database.database().reference()
    
    init() {
        observeColorChanges()
    }
    
    func observeColorChanges() {
        ref.child("colors/primary").observe(.value) { [weak self] snapshot in
            guard let value = snapshot.value as? [String: String],
                  let hex = value["hex"],
                  let name = value["name"] else {
                print("Error: No se pudo obtener el color primario")
                return
            }
            DispatchQueue.main.async {
                self?.backgroundColor = AppColor(hex: hex, name: name)
            }
        } withCancel: { error in
            print("Error al observar cambios: \(error.localizedDescription)")
        }
    }
}
