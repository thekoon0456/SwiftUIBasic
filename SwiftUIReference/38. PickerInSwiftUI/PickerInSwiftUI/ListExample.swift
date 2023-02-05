//
//  ListExample.swift
//  PickerInSwiftUI
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

struct ListExample: View {
    
    @State private var selectedName: String = ""
    
    let names: [String] = [
        "Tunde",
        "Billy",
        "Bob"
    ]
    
    var body: some View {
        //MARK: - List 내에 작성 - 컬럼 별로 나눠서 만들 수 있어서 편리
        List {
            
            
            Text("Selected Name \(selectedName)")
            Picker("Choose a name",
                   selection: $selectedName) {
                ForEach(names, id: \.self) { name in
                    Text(name)
                }
            }
            .pickerStyle(.menu)
            
            Picker("Choose a name",
                   selection: $selectedName) {
                ForEach(names, id: \.self) { name in
                    Text(name)
                }
            }
            .pickerStyle(.inline) //리스트에서는 list로 보임
            
            Picker("Choose a name",
                   selection: $selectedName) {
                ForEach(names, id: \.self) { name in
                    Text(name)
                }
            }
            .pickerStyle(.segmented)
            
            Picker("Choose a name",
                   selection: $selectedName) {
                ForEach(names, id: \.self) { name in
                    Text(name)
                }
            }
            .pickerStyle(.wheel) //리스트에서도 wheel로 보임
            
            Picker("Choose a name",
                   selection: $selectedName) {
                ForEach(names, id: \.self) { name in
                    Text(name)
                }
            }
            .pickerStyle(.automatic)
            
        }
    }
}

struct ListExample_Previews: PreviewProvider {
    static var previews: some View {
        ListExample()
    }
}
