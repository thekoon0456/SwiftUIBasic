//
//  ContentView.swift
//  TestProject
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

struct ContentView: View {

    @State private var quantityExampleOne: Int = 0
    @State private var quantityExampleTwo: Int = 0
    @State private var quantityExampleThree: Int = 0
    @State private var quantityExampleFour: Int = 0
    @State private var quantityExampleFive: Int = 0

    private let step: Int = 1
    private let range: ClosedRange<Int> = 0...20
    
    var body: some View {
        VStack {
            
            VStack {
                Text("The user selected a quantity of \(quantityExampleOne)")
                Stepper("Quantity",
                        value: $quantityExampleOne,
                        in: range, //범위
                        step: step) //증가분
            }
            
            VStack {
                Text("The user selected a quantity of \(quantityExampleTwo)")
                Stepper("",
                        value: $quantityExampleTwo,
                        in: range,
                        step: step)
                    .labelsHidden() //stepper 제목 숨기기
            }
            
            VStack {
                
                Stepper(value: $quantityExampleThree,
                        in: range,
                        step: step) { //클로저로 lable 추가 가능
                    Text("🍕 Slices \(quantityExampleThree)")
                }
            }
            
            VStack {
                
                Stepper(value: $quantityExampleFour,
                        in: range,
                        step: step) {
                    Text("🍔 Burgers \(quantityExampleFour)")
                } onEditingChanged: { editingStarted in //onEditingChanged: Stepper옵션. 변화 파악 //editingStarted: Bool값, editing중인지
                    print("The value changed \(editingStarted) the current quantity is \(quantityExampleFour)")
                }
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
