//
//  BlogViewModel.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 21.10.2021.
//

import ButterCMSSDK
import Combine

class BlogViewModel {
    var errorMessage = PassthroughSubject<String, Never>()
    @Published private(set) var posts: [Post]?
    private var subscriptions = Set<AnyCancellable>()

    init() {
        ButterCMSManager.shared.blogSubject
            .compactMap { value in
                value.data
            }
            .sink(
                receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error): self.errorMessage.send(ErrorString.getString(error: error))
                        }
                    },
                receiveValue: { [weak self] value in self?.posts = value }
            )
            .store(in: &subscriptions)
    }

    func reload() {
        ButterCMSManager.shared.getPosts()
    }
}
