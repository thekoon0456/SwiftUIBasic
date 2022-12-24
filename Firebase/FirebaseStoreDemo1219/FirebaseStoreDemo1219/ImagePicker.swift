//
//  ImagePicker.swift
//  FirebaseStoreDemo1219
//
//  Created by Deokhun KIM on 2022/12/19.
//

import Foundation
import UIKit
import SwiftUI

//UI 클래스를 스유 프로젝트로
struct ImagePicker: UIViewControllerRepresentable {
    //컨텐츠뷰에서 선택한 이미지 바인딩해서 가져오기
    @Binding var selectedImage: UIImage?
    //이미지 피터 닫기위해 바인딩
    @Binding var isPickerShowing: Bool
    //UI뷰 컨트롤러 만듬
    //UIImagePickerController의 인스턴스 생성, 스유 뷰로 반환
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let imagePicker = UIImagePickerController()
        //.photoLibrary 지원 중단 예정
        imagePicker.sourceType = .photoLibrary
        //이벤트 수신, delegate 할당
        imagePicker.delegate = context.coordinator //Coordinator()인스턴스 생성하고 delegate에 할당 //UIImagePickerController 이벤트 받기.
        
        
        return imagePicker
    }
    
    //UI뷰 업데이트
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
}
//사용자가 무엇을 선택했을때 이미지 피커가 호출할 메서드 처리, 위의 imagePicker.delegate로 할당
class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //바인딩 변수에 접근하기 위해 init
    var parent: ImagePicker
    
    init(_ picker: ImagePicker) {
        self.parent = picker
    }
    
    //유저가 이미지 선택했을때
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //이미지 선택되었을때 실행됨
        print("image selected")
        //이미지는 info 딕셔너리에 있음
        //사용자가 선택한 이미지가 딕셔너리에 전달할 키값, 이걸로 검색함
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //이미지 얻을 수 있음, UI변경하므로 메인 스레드에서 실행되도록
            DispatchQueue.main.async {
                self.parent.selectedImage = image
            }
        }
        //피커 닫기
        parent.isPickerShowing = false
    }
    
    //사용자가 피커 취소했을때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled")
        //피커 닫기
        parent.isPickerShowing = false
    }
}
