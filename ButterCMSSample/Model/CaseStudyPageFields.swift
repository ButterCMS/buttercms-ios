//
//  CaseStudyPageFields.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 22.10.2021.
//

import Foundation
import UIKit
import ButterCMSSDK

struct CaseStudyPageFields: Codable {
    var title: String
    var content: String
    var industry: String
    var subindustry: String
    var featuredImage: String
    var reviewer: String
    var studyDate: Date
}
