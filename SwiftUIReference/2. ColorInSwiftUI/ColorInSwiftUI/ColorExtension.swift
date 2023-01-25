//
//  Colors.swift
//  cokcok
//
//  Created by Deokhun KIM on 2023/01/25.
//

import SwiftUI
 
extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }

}

extension Color {
    static let cokcokPink = Color(hex: "FFB6E2")
    static let cokcokRed = Color(hex : "FF5B83")
    static let cokcokGreen = Color(hex : "ACFF7A")
    static let cokcokYellow = Color(hex : "EDFF35")
    static let cokcokOrange = Color(hex : "FF9B4A")
}
