//
//  FaqCollectionViewModel.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 26.10.2021.
//

import ButterCMSSDK
import Combine

class FaqCollectionViewModel {
    @Published  private(set) var collection: [FaqCollectionItem]?
    var errorMessage = PassthroughSubject<String, Never>()
    private var subscriptions = Set<AnyCancellable>()

    init () {
        ButterCMSManager.shared.faqCollectionSubject
            .compactMap { value in
                value.data.items
            }.sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error): self.errorMessage.send(ErrorString.getString(error: error))
                    }
                },
                receiveValue: { [weak self] value in self?.collection = value }
            )
            .store(in: &subscriptions)
    }

    func reload() {
        ButterCMSManager.shared.getCollection()
    }
}
