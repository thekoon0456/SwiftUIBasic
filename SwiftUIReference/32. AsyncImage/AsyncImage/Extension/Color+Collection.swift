//
//  Color+Collection.swift
//  Color+Collection
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

extension Color {
    
    static var random: Color {
        
        let possibleColors: [Color] = [
            .red,
            .orange,
            .yellow,
            .green,
            .mint,
            .teal,
            .cyan,
            .blue,
            .indigo,
            .purple,
            .pink,
            .brown,
            .gray,
            .black,
            .primary,
            .secondary
        ]
    
        return possibleColors.randomElement()!
    }
}
