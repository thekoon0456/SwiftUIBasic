//
//  MockData.swift
//  iOSConcurrency1218
//
//  Created by Deokhun KIM on 2022/12/25.
//

import Foundation

extension User {
    //번들파일에서 디코딩
    static var mockUsers: [User] {
        Bundle.main.decode([User].self, from: "users.json")
    }
    //user배열의 첫번째 항목
    static var mockSingleUser: User {
        self.mockUsers[0]
    }
}

extension Post {
    static var mockPosts: [Post] {
        Bundle.main.decode([Post].self, from: "posts.json")
    }
    static var mockSinglePost: Post {
        self.mockPosts[0]
    }
    //단일사용자를 위한 포스트 추가
    static var mockSingleUsersPostsArray: [Post] {
        //유저 아이디가 1인 사용자만 있을때
        self.mockPosts.filter { $0.userId == 1 }
    }
}
