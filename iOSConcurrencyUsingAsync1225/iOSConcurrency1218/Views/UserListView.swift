//
//  UserListView.swift
//  iOSConcurrency1218
//
//  Created by Deokhun KIM on 2022/12/18.
//

import SwiftUI

struct UserListView: View {
    //뷰모델이 인스턴스화될때마다 사용자 배열을 빈 배열로 초기화함, 뷰에 그릴때 vm.fetchUsers()로 json 데이터 가져와 배열에 넣음
    @StateObject var vm = UserListViewModel() //convenience init으로 호출하지 않고 볼수 있음
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.users) { user in
                    NavigationLink {
                        //PostListView에 user.id전달
                        PostListView(userId: user.id)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.largeTitle)
                            Text(user.email)
                        }
                    }
                }
            }
            //뷰모델이 로딩중일때 프로그레스뷰 나오도록 .overlay사용
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
            .navigationTitle("Users")
            .listStyle(.plain)
            //이 뷰가 나타날때 뷰모델 호출해서 fetchUsers() 호출. 유저 가져오고 뷰 업데이트
            .task {
                await vm.fetchUsers()
            }
        }
        .padding()
    }
}

//프리뷰 컨텐츠 에셋으로 네트워크에서 받아오지 않고 json바로 가져와서 보여줌
struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
