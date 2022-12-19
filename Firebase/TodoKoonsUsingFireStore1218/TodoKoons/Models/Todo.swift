//
//  Todo.swift
//  TodoKoons
//
//  Created by Deokhun KIM on 2022/12/18.
//

import Foundation

struct Todo: Identifiable { //Identifiable - 나중에 인덱싱할때 필요, List에서 id: \.self 안해도 됨
    var id: String
    var name: String
    var notes: String
}
