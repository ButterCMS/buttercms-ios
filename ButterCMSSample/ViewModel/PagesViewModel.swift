//
//  PagesViewModel.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 22.10.2021.
//

import ButterCMSSDK
import Combine
import UIKit

class PagesViewModel {
    @Published private(set) var pages: [CaseStudyPage]?
    var errorMessage = PassthroughSubject<String, Never>()
    private var subscriptions = Set<AnyCancellable>()

    init() {
        ButterCMSManager.shared.caseStudyPagesSubject
            .compactMap { value in
                value.data.compactMap { page in
                    let pageData = CaseStudyPage(pageData: page, image: nil)
                    if let url = URL(string: page.fields.featuredImage) {
                        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
                            if let data = data {
                                pageData.image = UIImage(data: data)
                            }
                        }
                        dataTask.resume()
                    }
                    return pageData
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
