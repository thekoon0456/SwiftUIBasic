//
//  Post.swift
//  iOSConcurrency1218
//
//  Created by Deokhun KIM on 2022/12/18.
//

import Foundation

//Source: https://jsonplaceholder.typicode.com/posts
//한명 유저 포스트: https://jsonplaceholder.typicode.com/users/1/posts

//JSON과 같은 이름의 상수 만들기
struct Post: Codable, Identifiable {//각 고유 id, 식별 가능한 프로토콜 Identifiable 채택
    let userId: Int
    let id: Int
    let title: String
    let body: String
    let test: String
}
