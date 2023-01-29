//
//  ContentView.swift
//  TestProject
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

struct ContentView: View {

    struct User {
        var username: String = ""
        var password: String = ""
    }
    
    @State private var user: User = .init()
    //텍스트필드가 활성화에 따라 bool값으로 조정 가능
    @FocusState private var inputFocused: Bool

    var body: some View {
        VStack {
            usernameTxtVw
            passwordTxtVw
            submitBtn
        }
        .padding()
        .textFieldStyle(.roundedBorder) //텍스트필트 roundedBorder 설정
        .disableAutocorrection(true) //자동 수정 비활성화
        .textInputAutocapitalization(.never) //첫 글자 대문자 비활성화
        //toolbar 사용해 Done 버튼 만들어 키보드 내릴 수 있음
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()

                Button(action: resignKeyboard) {
                    Text("Done")
                }
            }
        }
        .onSubmit(of: .text, submit) //done 누르면 submit 함수가 실행됨
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private extension ContentView {
    
    var usernameTxtVw: some View {
        TextField("Username",
                  text: $user.username,
                  prompt: Text("Username")) //prompt: placeHolder 처럼 사용. TextField title보다 우선 적용됨
            .textContentType(.username) //텍스트필드 타입 설정 가능
            .focused($inputFocused) //FocusState 사용해 키보드 온오프 가능
    }
    
    var passwordTxtVw: some View {
        SecureField("Password",
                  text: $user.password,
                  prompt: Text("Password"))
            .textContentType(.password)
            .focused($inputFocused)
            .submitLabel(.done) //작성 완료하면 return 버튼이 파란색 done으로 바뀜
    }
    
    var submitBtn: some View {
        Button(action: submit) {
            Text("Submit")
        }
    }
}

private extension ContentView {
    
    func submit() {
        print("The user inputted: \(user)")
        resignKeyboard()
    }
    
    func resignKeyboard() {
        //iOS 버전에 따라 다르게 작동
        if #available(iOS 15, *) {
            inputFocused = false
        } else {
            dismissKeyboard()
        }
    }
}

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

