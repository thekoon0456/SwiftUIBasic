
import SwiftUI

struct ContentView: View {
    @State private var inputText: String = "시작"
    
    var body: some View {
        VStack {
            Text("UIViewRepresentable")
                .padding(10)
            Text("InputText: \(inputText)")
            CustomUITextField(text: $inputText)
                .frame(width: 400, height: 300)
                .padding(10)
        }
        .onChange(of: inputText) {
            print("inputText: \(inputText)")
        }
    }
}

struct CustomUITextField: UIViewRepresentable {
    typealias UIViewType = UITextField
    @Binding var text: String
    
    //typealias에 선언한 타입이 리턴타입으로, 뷰 구성
    func makeUIView(context: Context) -> UITextField {
        let textField: UITextField = {
            let textField = UITextField()
            textField.delegate = context.coordinator //Delegate로 만든 coordinator 설정
            textField.placeholder = "UITextField입니다."
            textField.backgroundColor = .green
            return textField
        }()
        
        return textField
    }
    
    //typealias에 선언한 타입이 uiView 타입으로, 뷰 업데이트시
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        print(text)
    }
    
    //뷰 사이즈 설정
    func sizeThatFits(
        _ proposal: ProposedViewSize,
        uiView: UITextField,
        context: Context
    ) -> CGSize? {
        CGSize(width: 300, height: 100)
    }
    
    //coordinator 설정 (Delegate)
    func makeCoordinator() -> Coordinator {
        Coordinator(terget: self)
    }
    
    //Coordinator 구현 (NSObject, 채택할 Delegate)
    class Coordinator: NSObject, UITextFieldDelegate {
        var terget: CustomUITextField
        
        init(terget: CustomUITextField) {
            self.terget = terget
        }
        
        //입력된 텍스트 바뀔때
        func textField(
            _ textField: UITextField,
            shouldChangeCharactersIn range: NSRange,
            replacementString string: String
        ) -> Bool {
            if let text = textField.text {
                terget.text = text //바인딩 값 바꿔주기
                print(text)
            }
            
            return true
        }
        
        // 리턴 눌렸을때
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() // 키보드 숨기기
            print("리턴 눌림")
            
            return true
        }
    }
}

#Preview {
    ContentView()
}
