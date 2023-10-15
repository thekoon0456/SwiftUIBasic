//
//  GithubView.swift
//  SwiftUI+Combine
//
//  Created by Deokhun KIM on 2023/09/23.
//

import SwiftUI
import Combine

struct GithubView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("깃허브 프로필 컴바인으로 가져오기~!")
                .font(.title)
                .frame(maxWidth: .infinity,
                       alignment: .center)
                .padding(.vertical, 10)
            
            if vm.isLoading {
                VStack {
                    ProgressView()
                        .frame(width: 300, height: 300)
                    Text("로딩중입니다...")
                }
            } else {
                Group {
                    if vm.errorMessage != nil {
                        Text("통신 에러: \(vm.errorMessage!)")
                    }
                    
                    TextField("아이디를 입력해주세요",
                              text: $vm.userId)
                    .textFieldStyle(.roundedBorder)
                    Text("유저 이름: \(vm.user?.name ?? "")")
                    Text("유저 URL: \(vm.user?.htmlUrl ?? "")")
                    AsyncImage(url: vm.user?.avatarUrl) { phase in
                        switch phase {
                        case .empty:
                            Color.gray
                                .frame(width: 200, height: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        case .failure:
                            Text("이미지 로드 실패")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    Text("유저 bio: \(vm.user?.bio ?? "")")
                    Text("유저 위치: \(vm.user?.location ?? "")")
                    Text("팔로워: \(vm.user?.followers ?? 0) , 팔로잉: \(vm.user?.following ?? 0)")
                }
            }
            
            Button {
                vm.fetchUser()
            } label: {
                Text("유저 정보 가져오기")
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    GithubView()
}
