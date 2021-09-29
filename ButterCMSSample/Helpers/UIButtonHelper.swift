//
//  UIButtonHelper.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 27.09.2021.
//

import UIKit
extension UIButton {
func allowTextToScale(minFontScale: CGFloat = 0.5, numberOfLines: Int = 1) {
    self.titleLabel?.adjustsFontSizeToFitWidth = true
    self.titleLabel?.minimumScaleFactor = minFontScale
    self.titleLabel?.lineBreakMode = .byTruncatingTail
    self.titleLabel?.numberOfLines = numberOfLines
    }
}
