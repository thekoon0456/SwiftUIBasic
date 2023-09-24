//
//  UserError.swift
//  CurrentValueSubject
//
//  Created by Deokhun KIM on 2023/02/05.
//

import Foundation

enum UserError: Error {
    case invalid
}

extension UserError {
    
    public var errorDescription: String {
        switch self {
        case .invalid:
            return "Form is invalid"
        }
    }
}
