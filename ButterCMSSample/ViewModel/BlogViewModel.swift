//
//  BlogViewModel.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 21.10.2021.
//

import Foundation
import Combine

class BlogViewModel {
    var errorMessage = PassthroughSubject<String, Never>()
    @Published private(set) var homePage: [TableViewSectionType: [Any]]?
    private var subscriptions = Set<AnyCancellable>()
}
