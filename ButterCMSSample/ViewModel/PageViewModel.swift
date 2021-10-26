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
    @Published private(set) var title: String?
    @Published private(set) var content: String?
    @Published private(set) var industry: String?
    @Published private(set) var subindustry: String?
    @Published private(set) var reviewedBy: String?
    @Published private(set) var studyDate: String?
    @Published private(set) var image: UIImage?

    private var errorMessage = PassthroughSubject<String, Never>()
    private var subscriptions = Set<AnyCancellable>()
    private let dateFormatter = DateFormatter(dateFormat: "MMM-dd-yyyy")

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
                    self?.studyDate = self?.dateFormatter.string(fromOptional: value.data.fields.studyDate)
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
