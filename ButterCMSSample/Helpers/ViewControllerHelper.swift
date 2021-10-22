//
//  ViewControllerHelper.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 21.10.2021.
//

import UIKit

extension UIViewController {
    func showErrorAllert(message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in }
        alert.addAction(alertAction)
        self.present(alert, animated: true) {
            () -> Void in
        }
    }
}
