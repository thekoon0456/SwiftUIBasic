//
//  PostListView.swift
//  iOSConcurrency1218
//
//  Created by Deokhun KIM on 2022/12/25.
//

import SwiftUI

struct PostListView: View {
    //뷰모델이 인스턴스화될때마다 사용자 배열을 빈 배열로 초기화함, 뷰에 그릴때 vm.fetchUsers()로 json 데이터 가져와 배열에 넣음
    @StateObject var vm = PostsListViewModel() //convenience init으로 호출하지 않고 볼수 있음
    //뷰모델의 userId는 아직nil
    var userId: Int?
    
    var body: some View {
            List {
                ForEach(vm.posts) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .overlay {
                if vm.isLoading {
                    ProgressView()
                }
            }
            .alert("Application Error", isPresented: $vm.showAlert, actions: {
                Button("OK") {}
            }, message: {
                if let errorMessage = vm.errorMessage {
                    Text(errorMessage)
                }
            })
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            
            //이 뷰가 나타날때 뷰모델 호출해서 fetchUsers() 호출. 유저 가져오고 뷰 업데이트
                .onAppear {
                    vm.userId = userId
                    vm.fetchPost()
                }
        .padding()
    }
}

//프리뷰 컨텐츠 에셋으로 네트워크에서 받아오지 않고 json바로 가져와서 보여줌
struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostListView(userId: 1)
        }
    }
}
