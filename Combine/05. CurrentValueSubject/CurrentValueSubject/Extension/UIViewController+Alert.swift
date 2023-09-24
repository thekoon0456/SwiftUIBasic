//
//  UIViewController+Alert.swift
//  CurrentValueSubject
//
//  Created by Deokhun KIM on 2023/02/05.
//

import UIKit

extension UIViewController {
    
    func showFailed(message: String) {
        
        let alert = UIAlertController(title: "Failed",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "Ok",
                              style: .cancel))
        self.present(alert,
                     animated: true)
    }
}
