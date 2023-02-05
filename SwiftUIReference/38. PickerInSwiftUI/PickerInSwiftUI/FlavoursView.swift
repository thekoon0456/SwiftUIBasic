//
//  FlavoursView.swift
//  PickerInSwiftUI
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

//Identifiable 프로토콜로 고유한 id 부여 /Hashable: 컬렉션 내에서 개체를 고유하게 식별.
struct Flavour: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let price: Decimal
}

extension Flavour {
    static let none: Flavour = .init(name: "", price: 0)
}

struct FlavoursView: View {
    
    @State private var selectedFlavour: Flavour = .none
    
    let flavours: [Flavour] = [
        .init(name: "Mint", price: 1.00),
        .init(name: "Vanilla", price: 2.00),
        .init(name: "Coffee", price: 3.00)
    ]
    
    var body: some View {
            VStack {
                Text("Selected Flavour \(selectedFlavour.name)")

                Picker("Choose a name",
                       selection: $selectedFlavour) {
                    ForEach(flavours) { item in
                        HStack {
                            Text(item.name)
                            Text(item.price, format: .currency(code: "GBP")) //통화 표현 가능
                        }
//                        .tag(item) //tag는 hashable. 안해도 작동되는듯?
                    }
                }
                .pickerStyle(.wheel)
            }
    }
}

struct FlavoursView_Previews: PreviewProvider {
    static var previews: some View {
        FlavoursView()
    }
}
