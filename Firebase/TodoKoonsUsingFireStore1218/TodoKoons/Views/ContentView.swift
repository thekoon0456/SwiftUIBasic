//
//  ContentView.swift
//  TodoKoons
//
//  Created by Deokhun KIM on 2022/12/18.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ViewModel()
    
    //텍스트 필드에 사용할 State 변수
    @State var name = ""
    @State var notes = ""
    
    var body: some View {
        VStack {
            //스유에서는 리스트에 버튼 두개이상 넣고 누르면 모든 버튼이 트리거됨
            //버튼에 대한 다른 스타일 적용하면 괜찮음
            List(model.list) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    
                    //업데이트 버튼
                    Button {
                        //todo 업데이트
                        model.updateData(todoToUpdate: item)
                    } label: {
                        Image(systemName: "pencil.circle")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    //삭제 버튼
                    Button {
                        //todo삭제
                        model.deleteData(todoToDelete: item)
                    } label: {
                        Image(systemName: "minus.circle")
                    }
                    .buttonStyle(BorderlessButtonStyle())

                }
                Text(item.name)
                Text(item.notes)
            }
            Divider()
            VStack(spacing: 5) {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Notes", text: $notes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button {
                    //ViewModel의 addData 함수 호출
                    model.addData(name: name, notes: notes)
                    //텍스트필드 초기화
                    name = ""
                    notes = ""
                } label: {
                    Text("Add Todo Item")
                }
            }
        }
    }
    //model이 데이터를 얻음
    init() {
        model.getData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
