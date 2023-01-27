//
//  ContentView.swift
//  ButtonsStylesInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                
                Button("Subscribe to the channel") { }
                .padding()
                .background(.red)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Button("Subscribe to the channel") { }
                .tint(.red)
                .buttonStyle(.borderedProminent)
                //버튼 border 설정 가능
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .controlSize(.large)
            }
            
            VStack(spacing: 16) {
                
                Text("Button Style Examples")
                    .bold()
                
                Button("Button Style Example") { }
                .tint(.mint)
                .buttonStyle(.borderedProminent) //주 버튼 느낌
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .controlSize(.large)
                
                Button("Button Style Example") { }
                .tint(.mint)
                .buttonStyle(.bordered) //보조버튼 느낌
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .controlSize(.large)
                
                Button("Button Style Example") { }
                .tint(.mint)
                .buttonStyle(.borderless) //border없음
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .controlSize(.large)
                
                Button("Button Style Example") { }
                .tint(.mint)
                .buttonStyle(.plain) //텍스트만 보임
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .controlSize(.large)
                
                Button("Button Style Example") { }
                .tint(.mint)
                .buttonStyle(.automatic) //device 따라 시스템이 설정
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .controlSize(.large)
                
            }
            
            VStack(spacing: 16) {
                
                Text("Button Border Shape Examples")
                    .bold()
                
                Button("Button Style Example") { }
                .tint(.teal)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 12))
                .controlSize(.large)
                
                Button("Button Style Example") { }
                .tint(.teal)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .controlSize(.large)
                
                Button("Button Style Example") { }
                .tint(.teal)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                
                Button("Button Style Example") { }
                .tint(.teal)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.automatic)
                .controlSize(.large) //버튼 컨트롤 크기 결정
                
                
            }
            
            VStack(spacing: 16) {
                
                Text("Button Control Size Examples")
                    .bold()
                
                Button("Button Style Example") { }
                .tint(.pink)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .controlSize(.mini)
                
                Button("Button Style Example") { }
                .tint(.pink)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .controlSize(.small)
                
                Button("Button Style Example") { }
                .tint(.pink)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .controlSize(.regular)
                
                Button("Button Style Example") { }
                .tint(.pink)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .controlSize(.large)
            }
            
            
            VStack(spacing: 16) {
                
                Text("Button Role & Style Examples")
                    .bold()
                //Button 스타일에 따라
                Button(role: .destructive) {
                    
                } label: {
                    Text("Delete")
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
                Button(role: .destructive) {
                    
                } label: {
                    Text("Delete")
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                
                Button(role: .cancel) {
                    
                } label: {
                    Text("Cancel")
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
                Button(role: .cancel) {
                    
                } label: {
                    Text("Cancel")
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
            
            VStack(spacing: 24) {
                
                Text("Material Examples")
                //Material 설정 조정
                Button("Material Example") { }
                .padding()
                .background(.ultraThinMaterial)
                .controlSize(.large)
                
                Button("Material Example") { }
                .padding()
                .background(.thinMaterial,
                            in: Capsule())
                .controlSize(.large)
                
                Button("Material Example") { }
                .padding()
                .background(.regularMaterial,
                            in: RoundedRectangle(cornerRadius: 8))
                .controlSize(.large)
                
                Button("Material Example") { }
                .padding()
                .background(.thickMaterial,
                            in: RoundedRectangle(cornerRadius: 8))
                .controlSize(.large)
                
                Button("Material Example") { }
                .padding()
                .background(.ultraThickMaterial,
                            in: RoundedRectangle(cornerRadius: 8))
                .controlSize(.large)
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.mint)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
