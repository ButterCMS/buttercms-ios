//
//  PageModel.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 22.10.2021.
//

import ButterCMSSDK
import Combine
import UIKit

class PageViewModel {
    @Published private(set) var title = ""
    @Published private(set) var content = ""
    @Published private(set) var industry = ""
    @Published private(set) var subindustry = ""
    @Published private(set) var reviewedBy = ""
    @Published private(set) var studyDate = ""
    @Published private(set) var image: UIImage?

    private var errorMessage = PassthroughSubject<String, Never>()
    private var subscriptions = Set<AnyCancellable>()

    init() {
        ButterCMSManager.shared.caseStudyPageSubject
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error): self.errorMessage.send(error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] value in
                    self?.title = value.data.fields.title
                    self?.content = value.data.fields.content
                    self?.industry = value.data.fields.industry
                    self?.subindustry = value.data.fields.subindustry
                    self?.reviewedBy = value.data.fields.reviewer
                    // self?.studyDate = value.data.fields.studyDate
                    if let url = URL(string: value.data.fields.featuredImage) {
                        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                            if let data = data {
                                self?.image = UIImage(data: data)
                            }
                        }
                        dataTask.resume()
                    }
                }
            )
            .store(in: &subscriptions)
    }

    func loadPage(slug: String) {
        ButterCMSManager.shared.getPage(slug: slug)
    }
}
