//
//  HomePage.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 17.09.2021.
//

struct HomePageFields: Codable {
    var headline: String
    var subheadline: String
    var section: [Section]
    var documentationurl: String
}

struct Section: Codable {
    var title: String
    var subtitle: String
    var buttonurl: String
}

struct HomePageHeader {
    var headline: String
    var subheadline: String
}

enum TableViewSectionType: Int {
    case header
    case sections
    case docUrl
}
