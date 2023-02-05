//
//  Person.swift
//  Person
//
//  Created by Deokhun KIM on 2023/02/05.
//

import Foundation

struct Person: Identifiable {
    
    enum Gender: String {
        case male = "👨"
        case female = "👩"
        case genderNeutral = "👱"
    }
    
    let id = UUID()
    let name: String
    let gender: Gender
}

