//
//  AppColor.swift
//  technical-test-ios
//
//  Created by Luis Segoviano on 04/08/25.
//

import Foundation
import SwiftUI

struct AppColor {
    let hex: String
    let name: String
    
    var color: Color {
        Color(hex: hex)
    }
}
