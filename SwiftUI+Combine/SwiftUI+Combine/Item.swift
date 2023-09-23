//
//  Item.swift
//  SwiftUI+Combine
//
//  Created by Deokhun KIM on 2023/09/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
