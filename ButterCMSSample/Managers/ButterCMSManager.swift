//
//  ButterCMSManager.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 17.09.2021.
//

import ButterCMSSDK
import Combine

class ButterCMSManager {
    static var shared = ButterCMSManager()
    let butter = ButterCMSClient(apiKey: "3606556ecbd4134ea24b8936a829ab9edaddb583")
    let homePageSubject = PassthroughSubject<PageResponse<HomePageFields>, Error>()

    func getHomePage() {
        butter.getPage(slug: "homepage", parameters: [.locale(value: "en")], pageTypeSlug: "homepage", type: HomePageFields.self) { result in
            switch result {
            case .success(let page):
                self.homePageSubject.send(page)
            case .failure(let error):
                self.homePageSubject.send(completion: .failure(error))
            }
        }
    }
}
