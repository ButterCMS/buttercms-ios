//
//  PagesViewModel.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 22.10.2021.
//

import ButterCMSSDK
import Combine
import UIKit
import AlamofireImage

class PagesViewModel {
    @Published private(set) var pages: [PageCellViewModel]?
    var errorMessage = PassthroughSubject<String, Never>()
    private var subscriptions = Set<AnyCancellable>()

    init() {
        ButterCMSManager.shared.caseStudyPagesSubject
            .compactMap { value in
                value.data.compactMap { page in
                    PageCellViewModel(page: page)
                }
            }
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error): self.errorMessage.send(error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] value in self?.pages = value }
            )
            .store(in: &subscriptions)

    }

    func reload() {
        ButterCMSManager.shared.getPages()
    }
}

class PageCellViewModel {
    var title: String
    var studyDate: String
    var reviewedBy: String
    var imageLink: String
    var slug: String
    private let dateFormatter = DateFormatter(dateFormat: "MMM-dd-yyyy")
    
    init (page: Page<CaseStudyPageFields>) {
        self.slug = page.slug
        self.title = page.fields.title
        self.studyDate = dateFormatter.string(from: page.fields.studyDate)
        self.reviewedBy = page.fields.reviewer
        self.imageLink = page.fields.featuredImage
    }
}
