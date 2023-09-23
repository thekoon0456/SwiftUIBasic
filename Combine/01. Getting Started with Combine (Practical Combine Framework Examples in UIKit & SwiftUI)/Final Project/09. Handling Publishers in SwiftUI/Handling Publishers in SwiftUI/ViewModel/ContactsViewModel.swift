//
//  ContactsViewModel.swift
//  Handling Publishers in SwiftUI
//
//  Created by Deokhun KIM on 2023/02/05.
//

import Combine

class ContactsViewModel: ObservableObject {
        
    @Published private(set) var contacts = [Contact]()
        
    func add(contact: Contact) {
        contacts.append(contact)
    }
}
