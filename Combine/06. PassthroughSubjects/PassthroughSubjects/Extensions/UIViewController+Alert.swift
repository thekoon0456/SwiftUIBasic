//
//  UIViewController+Alert.swift
//  PassthroughSubjects
//
//  Created by Deokhun KIM on 2023/02/05.
//

import Foundation

import UIKit

extension UIViewController {
    
    func showBlocked() {
        
        let alert = UIAlertController(title: "Ooops",
                                      message: "Thought you were tough right? Well guess what you're banned",
                                      preferredStyle: .alert)
        self.present(alert,
                     animated: true)
    }
}
