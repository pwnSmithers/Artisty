//
//  UIAlertController+Extension.swift
//  MobileChallenge
//
//  Created by Smithers on 26/04/2021.
//

import UIKit

extension UIAlertController {
    static func userEnteredEmptySearchString(onConfirm: @escaping () -> Void) -> UIAlertController {
        let ok = UIAlertAction(title: "OK", style: .default) { _  in
            onConfirm()
        }
        
        let alert = UIAlertController(title: "Error", message: "Please enter an artist's name", preferredStyle: .alert)
        
        alert.addAction(ok)
        return alert
    }
}
