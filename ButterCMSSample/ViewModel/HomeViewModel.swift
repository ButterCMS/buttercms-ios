//
//  HomeViewModel.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 17.09.2021.
//

import ButterCMSSDK
import Combine

class HomeViewModel {
    var errorMessage = PassthroughSubject<String, Never>()
    @Published private(set) var homePage: [TableViewSectionType: [Any]]?
    private var subscriptions = Set<AnyCancellable>()

    init () {
        ButterCMSManager.shared.homePageSubject
            .compactMap { response in
                [.header: [HomePageHeader(headline: response.data.fields.headline, subheadline: response.data.fields.subheadline)],
                 .sections: response.data.fields.section,
                 .docUrl: [response.data.fields.documentationurl]
                ]
            }
            .sink(
                receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error): self.errorMessage.send(ErrorString.getString(error: error))
                        }
                    },
                receiveValue: { [weak self] value in self?.homePage = value }
            )
            .store(in: &subscriptions)
    }

    func reload() {
        ButterCMSManager.shared.getHomePage()
    }
}
