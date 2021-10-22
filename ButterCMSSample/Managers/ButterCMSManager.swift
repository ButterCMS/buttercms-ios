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
    let blogSubject = PassthroughSubject<PostsResponse, Error>()
    let postSubject = PassthroughSubject<PostResponse, Error>()
    
    func getHomePage () {
        butter.getPage(slug: "homepage", parameters: [.locale(value: "en")], pageTypeSlug: "homepage", type: HomePageFields.self) { result in
            switch result {
            case .success(let page):
                self.homePageSubject.send(page)
            case .failure(let error):
                self.homePageSubject.send(completion: .failure(error))
            }
        }
    }
    
    func getPosts() {
        butter.getPosts(parameters: [.excludeBody]) { result in
            switch result {
            case .success(let posts):
                self.blogSubject.send(posts)
            case .failure(let error):
                self.blogSubject.send(completion: .failure(error))
            }
        }
    }
    
    func getPost(slug: String) {
        butter.getPost(slug: slug) { result in
            switch result {
            case .success(let post):
                self.postSubject.send(post)
            case .failure(let error):
                self.postSubject.send(completion: .failure(error))
            }
        }
    }
}
