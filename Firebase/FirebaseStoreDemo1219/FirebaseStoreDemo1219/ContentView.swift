//
//  ContentView.swift
//  FirebaseStoreDemo1219
//
//  Created by Deokhun KIM on 2022/12/19.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct ContentView: View {
    
    @State private var isPickerShowing = false
    //선택된 이미지를 바인딩으로 이미지 피커에 전달
    @State private var selectedImage: UIImage?
    @State var retrievedImages = [UIImage]() //검색된 이미지들 배열로
    var body: some View {
        
        VStack {
            
            if selectedImage != nil {
                Image(uiImage: selectedImage!).resizable()
                    .frame(width: 200, height: 200)
            }
            
            Button {
                //이미지 피커 보여주기
                isPickerShowing = true
            } label: {
                Text("Select a Photo")
            }
            
            //파이어스토어 업로드 버튼
            if selectedImage != nil {
                Button {
                    //업로드 이미지
                uploadPhoto()
                } label: {
                    Text("Upload photo")
                }

            }
            
            Divider()
            
            HStack {
                //검색된 이미지들 UI에 보여주ㅡㅁ
                ForEach(retrievedImages, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 200, height: 200)
                }
            }
        }
        .sheet(isPresented: $isPickerShowing) {
            //이미지 피커, UIImagePickerController, UIKit과 연동 필요
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
        }
        .onAppear {
            retrievePhotos()
        }
        .padding()
        

    }
    func uploadPhoto() {
        //이미지 프로퍼티가 nil인지 확인
        guard selectedImage != nil else {
            return
        }
        
        //storage ref 만듬
        let storageRef = Storage.storage().reference()
        //이미지를 데이터로 전활할 수 있는지 확인
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8) //압축품질 0.8로
        
        //이미지를 데이터로 전환할수 있는지 확인, 확인했으므로 밑에 putData는 !로 간편하게 언래핑
        guard imageData != nil else {
            return
        }
        
        //파일 경로, 이름 지정, image 폴더에 접근
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        //데이터 업로드
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            
            //에러 체크
            if error == nil && metadata != nil {
                //ref 파이어스토어 db에 저장
                let db = Firestore.firestore()
                db.collection("images").document().setData(["url":path]) {
                    error in


                        //에러 없을때 새 이미지 표시
                        if error == nil {
                            //UI업데이트하므로 디스패치큐
                            DispatchQueue.main.async {
                            self.retrievedImages.append(self.selectedImage!)
                        }
                    }
                }
            }
        }
    }
    
    func retrievePhotos() {
        //데이터베이스에서 데이터 가져옴
        let db = Firestore.firestore()
        
        db.collection("images").getDocuments { snapshot, error in
            
            if error == nil && snapshot != nil {
                
                var paths = [String]()
                
                //반환된 모든 문서
                for doc in snapshot!.documents { //snapshot nil아니므로 강제언래핑 해도 괜찮음
                    //파일 경로 추출하고 paths 배열에 경로 추가
                    paths.append(doc["url"] as! String)
                }
                //파일 경로 반복하고, 스토리지에서 데이터 가져옴
                for path in paths {
                    //스토리지에서 참조 얻기
                    let storageRef = Storage.storage().reference()
                    
                    //경로지정
                    let fileRef = storageRef.child(path)
                    
                    //데이터 검색 /데이터 최대 크기 지정,(5메가)
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        //에러 체크
                        if error == nil && data != nil {
                            //UIImage생성해서 배열에 넣음
                            if let image = UIImage(data: data!) {
                                
                                DispatchQueue.main.async {
                                    retrievedImages.append(image)
                                }
                            }
                        }
                    }
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
