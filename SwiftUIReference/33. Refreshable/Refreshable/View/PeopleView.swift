//
//  PeopleView.swift
//  PeopleView
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

struct PeopleView: View {
    
    @Environment(\.refresh) private var refreshAction //옵셔널타입. 언래핑가능
    @ObservedObject var vm: PeopleViewModel
    
    var body: some View {
        VStack {
            List {
                HintView()
                ForEach(vm.people) { person in
                    
                    Text("\(person.gender.rawValue) \(person.name)")
                }
            }
            .listRowSeparator(.hidden)
            .navigationTitle("Random Person")
            .toolbar { //툴바로 새로고침 추가
                refreshContent
            }
        }
    }
    
    @ViewBuilder
    var refreshContent: some View {
        if let refreshAction = refreshAction {
            
            if vm.isLoading {
                ProgressView()
            } else {
                Button {
                    Task {
                        await refreshAction()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView(vm: PeopleViewModel())
    }
}
