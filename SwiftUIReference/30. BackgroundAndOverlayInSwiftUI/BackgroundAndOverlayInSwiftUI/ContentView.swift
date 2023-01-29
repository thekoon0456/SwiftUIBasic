//
//  ContentView.swift
//  BackgroundAndOverlayInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

//background 와 overlay 의 차이점.
struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                
                Text("5")
                    .font(.footnote.weight(.bold))
                    .padding()
                    .background {
                        Image(systemName: "star")
                            .symbolVariant(.fill)
                            .foregroundColor(.white)
                            .font(.system(size: 32))
                            .offset(y: -2)
                    }
                    .background(.yellow)
            
                Text("5")
                    .font(.footnote.weight(.bold))
                    .padding()
                    .background {
                        
                        Circle()
                            .fill(.yellow.opacity(0.3))
                        
                        Image(systemName: "star")
                            .symbolVariant(.fill)
                            .foregroundColor(.yellow)
                            .font(.system(size: 32))
                            .offset(y: -2)
                    }
                
                Text("5")
                    .font(.footnote.weight(.bold))
                    .padding()
                    .background {
                        
                        Image(systemName: "star")
                            .symbolVariant(.fill)
                            .foregroundColor(.yellow)
                            .font(.system(size: 32))
                            .offset(y: -2)
                        
                        Circle()
                            .fill(.mint)
                    }
                
                Text("5")
                    .font(.footnote.weight(.bold))
                    .padding()
                    .background(alignment: .top) {
                        
                        Image(systemName: "star")
                            .symbolVariant(.fill)
                            .foregroundColor(.yellow)
                            .font(.system(size: 32))
                            .offset(y: -2)

                    }
                
                Image("tundsdev")
                    .resizable()
                    .frame(width: 100,
                           height: 100)
                    .background(
                        Circle()
                            .fill(.blue)
                    )
                    .overlay(alignment: .bottom) {
                        Text("Subscribe")
                            .font(.footnote.weight(.bold))
                            .foregroundColor(.white)
                            .padding(4)
                            .background(
                                Capsule()
                                    .fill(.red)
                            )
                    }
                
                Image("tundsdev")
                    .resizable()
                    .frame(width: 100,
                           height: 100)
                    .background(
                        Circle()
                            .fill(.blue)
                    )
                    .overlay(alignment: .bottom) {
                        Text("Subscribe")
                            .font(.footnote.weight(.bold))
                            .foregroundColor(.white)
                            .padding(4)
                            .background(.ultraThinMaterial,
                                        in: Capsule())
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
