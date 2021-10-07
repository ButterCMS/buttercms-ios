//
//  HomeDocurlCell.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 27.09.2021.
//

import UIKit
import Combine

class HomeDocurlCell: UITableViewCell {
    let docUrlButtonClickedSubject = PassthroughSubject<String, Never>()

    @IBOutlet weak var docUrlButton: UIButton!

    @IBAction func docUrlButtonClicked(_ sender: Any) {
        docUrlButtonClickedSubject.send("https://buttercms.com/docs/api/?javascript#")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.docUrlButton.applyRoundCornders()
        self.docUrlButton.allowTextToScale()
    }
}
