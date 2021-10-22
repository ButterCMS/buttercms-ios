//
//  BlogsViewController.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 14.09.2021.
//

import UIKit
import Combine

class BlogViewController: UITableViewController {
    private var viewModel: BlogViewModel!
    private var subscriptions = Set<AnyCancellable>()
    private let dateFormatter = DateFormatter(dateFormat: "MMM-dd-yyyy")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "BlogCell", bundle: nil), forCellReuseIdentifier: "BlogCell")
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.viewModel = BlogViewModel()
        self.bind()
        self.viewModel.reload()
    }

    private func bind() {
        viewModel.$posts.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)

        viewModel.errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.showErrorAllert(message: message)
            }
            .store(in: &subscriptions)
    }

}

extension BlogViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as? BlogCell,
              let post = viewModel.posts?[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.author.text = "\(post.author?.firstName ?? "") \(post.author?.lastName ?? "")"
        cell.title.text = post.title
        cell.subTitle.text = post.slug
        cell.time.text = dateFormatter.string(fromOptional: post.published)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = viewModel.posts?[indexPath.row] else { return }
        if let postVC = UIStoryboard(name: "BacklogDetail", bundle: nil)
            .instantiateViewController(withIdentifier: "BlogPostViewControllerID") as? BlogPostViewController {
                postVC.slug = post.slug
            self.navigationController?.show(postVC, sender: self)
            }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
