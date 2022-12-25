//
//  User.swift
//  iOSConcurrency1218
//
//  Created by Deokhun KIM on 2022/12/18.
//

import Foundation
//JSON가져올 사이트: https://jsonplaceholder.typicode.com/users

struct User: Codable, Identifiable { //JSON 사용 위해 Codable 프로토콜
    //읽기만 하고 수정 안하니까 let
    let id: Int
    let name: String
    let username: String
    let email: String
    let test: String
}
