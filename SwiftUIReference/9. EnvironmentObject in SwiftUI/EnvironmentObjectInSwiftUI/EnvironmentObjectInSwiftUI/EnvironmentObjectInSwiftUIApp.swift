//
//  EnvironmentObjectInSwiftUIApp.swift
//  EnvironmentObjectInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/26.
//

import SwiftUI

@main
struct EnvironmentObjectInSwiftUIApp: App {
    
    @StateObject private var vm = PurchaseViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                PurchaseView()
                    .environmentObject(vm)
                    .tabItem {
                        Image(systemName: "creditcard")
                        Text("Purchase")
                    }
                PurchaseStateView()
                    .environmentObject(vm)
                    .tabItem {
                        Image(systemName: "gear")
                        Text("State")
                    }
            }
        }
    }
}
