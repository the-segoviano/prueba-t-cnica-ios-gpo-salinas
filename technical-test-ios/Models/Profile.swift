//
//  Profile.swift
//  technical-test-ios
//
//  Created by Luis Segoviano on 04/08/25.
//

import Foundation
import UIKit

// Modelo para representar un perfil recuperado de Firestore
struct Profile: Identifiable {
    let id: String
    let fullName: String
    let image: UIImage
}
