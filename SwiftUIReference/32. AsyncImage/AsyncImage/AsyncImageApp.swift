//
//  AsyncImageStarterApp.swift
//  AsyncImageStarter
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

@main
struct AsyncImageApp: App {
    
    @StateObject private var vm = MenuViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(vm)
            }
        }
    }
}
