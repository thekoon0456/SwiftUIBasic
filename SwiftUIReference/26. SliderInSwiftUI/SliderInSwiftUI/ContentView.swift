//
//  ContentView.swift
//  TestProject
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

struct ContentView: View {
    
    @State private var volume: Double = 0
    @State private var hasChanged: Bool = false //slider 편집중인지 상태 bool으로 표시
    
    private let range: ClosedRange<Double> = 0...100 //range 범위
    private let step: Double = 5
    
    var body: some View {
        VStack {
            Text("Current volume \(Int(volume))%") //기본 double값.
            
            HStack {
                 increaseBtn
                Slider(value: $volume, //바인딩되는 값
                       in: range, //값 범위
                       step: step) { //오르는 값
                    
                } minimumValueLabel: { //최소값
                    Text("\(Int(range.lowerBound))")
                } maximumValueLabel: { //최대값
                    Text("\(Int(range.upperBound))")
                } onEditingChanged: { hasChanged in //변경
                    self.hasChanged = hasChanged
                }

                 decreaseBtn
             }
            
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private extension ContentView {
    
    func increase() {
        guard volume < range.upperBound else { return } //range의 최대 설정값(100) 보다 작을때만 올라가도록
        volume += step
    }
    
    func decrease() {
        guard volume > range.lowerBound else { return }
        volume -= step
    }
}

private extension ContentView {
    
    var increaseBtn: some View {
        Button {
            withAnimation {
                increase()
            }
        } label: {
            Image(systemName: "plus")
        }
        .opacity(hasChanged ? 0.5 : 1) //slider 움직이는 중에는 opacity 0.5로 불투명하게
        .disabled(hasChanged)
    }
    
    var decreaseBtn: some View {
        Button {
            withAnimation {
                decrease()
            }
        } label: {
            Image(systemName: "minus")
        }
        .opacity(hasChanged ? 0.5 : 1)
        .disabled(hasChanged)
    }
}
