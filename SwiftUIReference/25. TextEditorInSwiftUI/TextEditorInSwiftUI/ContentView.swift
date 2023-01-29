//
//  ContentView.swift
//  TextEditorInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            descriptionTxtVw
            textEditorVw
            submitBtn
        }
        .padding()
    }
}

private extension ContentView {
    
    var descriptionTxtVw: some View {
        Text("Description")
    }
    
    var submitBtn: some View {
        Button {
            print("The user inputted: \(text)")
        } label: {
            Text("Submit")
        }
    }
    
    var textEditorVw: some View {
        TextEditor(text: $text)
            .frame(height: 250)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray.opacity(0.2), lineWidth: 4)
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
