//
//  PostViewModel.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 21.10.2021.
//

import Foundation

import ButterCMSSDK
import Combine

class PostViewModel {
    var errorMessage = PassthroughSubject<String, Never>()

    @Published private(set) var author = ""
    @Published private(set) var title = ""
    @Published private(set) var slug = ""
    @Published private(set) var time = ""
    @Published private(set) var body = ""

    private var subscriptions = Set<AnyCancellable>()

    init() {
        ButterCMSManager.shared.postSubject
            .sink(
                receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error): self.errorMessage.send(error.localizedDescription)
                        }
                    },
                receiveValue: { [weak self] value in
                    self?.author = "\(value.data.author?.firstName ?? "") \(value.data.author?.lastName ?? "")"
                    self?.title = value.data.title
                    self?.slug = value.data.slug
                    let dateFormatter = DateFormatter(dateFormat: "MMM-dd-yyyy")
                    self?.time = dateFormatter.string(fromOptional: value.data.published) ?? ""
                    if let body = value.data.body {
                        self?.body = body
                    } else {
                        self?.body = "<HTML><BODY><H1 align=\"center\">NO DATA</H1></BODY></HTML>"
                    }
                }
            )
            .store(in: &subscriptions)
    }

    func loadPost(slug: String) {
        ButterCMSManager.shared.getPost(slug: slug)
    }
}
