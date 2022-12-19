//
//  ViewMoel.swift
//  TodoKoons
//
//  Created by Deokhun KIM on 2022/12/18.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {
    @Published var list = [Todo]() //getData()가 반환되면 뷰에서 변화를 감지하고 뷰를 그림
    
    //데이터 업데이트 (데이터 추가와 매우 유사)
    func updateData(todoToUpdate: Todo) {
        //database에서 참조(reference) 얻기
        let db = Firestore.firestore()
        
        //업데이트할 데이터 경로지정, update함수실행
        //경로를 찾아가서 기존 데이터 다! 지우고 새로 입력한 데이터로 대체함 //setData마지막에 , merge: true를 하면 모두 지우고 대체하는 것이 아닌 수정한 내용만 수정되고 나머지는 기존 내용과 함께 결합됨
//        db.collection("todos").document(todoToUpdate.id).setData(["name" : "update todo name",
//                                                                  "notes" : "some notes"], merge: true)
        db.collection("todos").document(todoToUpdate.id).setData(["name" : "update todo name"], merge: true) { error in
            //에러체크
            if error == nil {
                //에러가 없으면 새 데이터를 가져옴
                self.getData()
            }
        }
    }
    
    
    
    //데이터 가져오기
    func getData() {
        //database에서 참조(reference) 얻기
        //firestore(): Firestore의 정적 메소드,데이터베이스와 상호작용하는데 사용할 객체에 대한 참조를 반환함
        let db = Firestore.firestore()
        
        //특정 path에서 문서를 읽기
        //컬렉션 내의 문서 추가 수정 삭제 등 접근 가능
        //.getDocuments: 컬렉션 내의 모든 문서 가져옴
        //쿼리를 수정하고, Todo컬렉션에서 모든 문서를 가져옴,
        db.collection("todos").getDocuments { snapshot, error in //snapshot:쿼리에서 반환되는 실제 문서가 매개변수로 저장됨, error: 발생한 모든 오류는 error 매개변수에 저장됨
            //에러 체크, 처리
            if error == nil {
                //에러 없음
                
                if let snapshot = snapshot {
                    
                    //기본적으로 백그라운드 스레드에서 작동하는데, 뷰를 업데이트하므로 메인 스레드에서 작동하게 하는게 좋음
                    DispatchQueue.main.async {
                        //모든 문서를 가져오고, todo구조체 인스턴스 Todo를 만듬
                        //snapshot의 문서속성 접근(모든 문서의 배열)
                        self.list = snapshot.documents.map { d in //각 문서를 map으로 변환, 결과를 컬렉션으로 var list에 반환
        
                            //딕셔너리 사용, 각 문서에 대해 Todo목록을 생성함
                            return Todo(id: d.documentID,
                                        name: d["name"] as? String ?? "", //"name"의 데이터 타입을 모르므로 타입 캐스팅
                                        notes: d["notes"] as? String ?? "") //todo구조체 인스턴스 Todo를 반환함
                        }
                    }

                }
            }
            else {
                //에러처리
            }
        }
    }
    
    //데이터 추가 (todo이름과 메모 전달)
    func addData(name: String, notes: String) {
        //database에서 참조(reference) 얻기
        let db = Firestore.firestore()
        
        //컬렉션에 문서 추가
        //data: [String : Any]는 문서 내부의 데이터, 딕셔너리 안에 추가할 키값 함수 매개변수로 넣음
        //.addDocument(data:, completion: )data: 문서 넣음, completion: 서버에서 호출이 돌아올때(나중에) 실행되는 매개변수,(여기서는 문서 생성하고 데이터를 추가하는데 오류가 있는지 알려주기 위해 사용)
        db.collection("todos").addDocument(data: ["name":name, "notes":notes]) { error in
            //error 체크해서 error가 없는 경우
            if error == nil {
                //에러없이 정상작동시, 데이터를 다시 가져와서 최신 todo 가져오려 함
                
                
                //최신 데이터 가져옴
                self.getData()
            }
            else {
                //에러처리
            }
            
        }
    }
    
    //데이터 삭제
    func deleteData(todoToDelete: Todo) {
        //데이터 베이스 레퍼런스 참조하고
        let db = Firestore.firestore()
        
        //삭제할 문서 지정, 경로 지정, delete()함수로 삭제
        db.collection("todos").document(todoToDelete.id).delete { error in //삭제되고 뒤의 클로저 실행. 실제 성공적으로 삭제되었는지 확인 가능
            //에러 체크
            if error == nil {
                //에러 없이 성공
                //메인스레드에서 삭제된 UI업데이트
                DispatchQueue.main.async {
                    //UI에서 즉시 제거하고 싶음
                    self.list.removeAll { todo in
                        //list목록 중에 삭제하려는 아이디와 일치하면 삭제
                        return todo.id == todoToDelete.id
                    }
                }
                

            }
        }
    }
}
