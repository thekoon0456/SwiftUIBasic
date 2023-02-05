//
//  PersonView.swift
//  ForEachIdentifiableInSwiftUI
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

struct PersonView: View {
    
    let person: Person
    
    var body: some View {
        Text("\(person.firstName) \(person.lastName)")
            .padding()
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(person: Person.data.first!)
    }
}
