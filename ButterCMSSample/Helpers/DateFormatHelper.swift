//
//  DateFormatHelper.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 21.10.2021.
//

import Foundation
extension DateFormatter {
    convenience init(dateFormat: String) {
       self.init()
       self.dateFormat = dateFormat
    }
}
