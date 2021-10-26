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

    func string(fromOptional: Date?, dafualtValue: String = "") -> String {
        guard let date = fromOptional else { return dafualtValue }
        return self.string(from: date)
    }
}
