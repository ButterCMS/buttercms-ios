//
//  UIScrallViewHelper.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 25.10.2021.
//

import UIKit
extension UIScrollView {
    func recalculateVerticalContentSize () {
        let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)
        self.contentSize = CGRect(x: 0, y: 0, width: self.frame.width, height: unionCalculatedTotalRect.height).size
        }

        private func recursiveUnionInDepthFor (view: UIView) -> CGRect {
            var totalRect = CGRect.zero
            for subView in view.subviews {
                totalRect =  totalRect.union(recursiveUnionInDepthFor(view: subView))
            }
            return totalRect.union(view.frame)
        }
}
