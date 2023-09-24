import UIKit
import Combine

//publisher의 값을 알고, 본질적으로 그 값을 관찰할 수 있게 해서 현재 값을 얻을 수 있고, 값을 변경할 수 있도록 함

//firstName, lastName입력하고 간단한 유효성 검사 후 메세지 출력
struct Person {
    var firstName: String
    var lastName: String
    var occupation: String
}

enum UserError: Error {
    case invalid
}

extension UserError {
    
    public var errorDescription: String {
        switch self {
        case .invalid:
            return "Form is invalid"
        }
    }
}

extension Person {
   
    var message: String {
        "\(firstName) \(lastName) is a \(occupation)"
    }
    
    var isValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !occupation.isEmpty
    }
}

let person = CurrentValueSubject<Person, Error>(Person(firstName: "",
                                                     lastName: "",
                                                     occupation: ""))

let subscription = person.sink { res in
    switch res {
    case .finished:
        print(person.value.message)
    case .failure(let error as UserError):
        print("Failed: \(error.errorDescription)")
    case .failure(let error):
        print("Failed: \(error.localizedDescription)")
    }
} receiveValue: { person in
    print("Updated: \(person)")
}

person.value.firstName = "Tunde"
person.value.lastName = "Adegoroye"
person.value.occupation = "iOS Developer"


if person.value.isValid {
    person.send(completion: .finished)
} else {
    person.send(completion: .failure(UserError.invalid))
}

