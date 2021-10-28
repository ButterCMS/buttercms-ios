//
//  PagesViewController.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 14.09.2021.
//

import UIKit
import Combine

class PagesViewController: UITableViewController {
    private var viewModel: PagesViewModel!
    private var subscriptions = Set<AnyCancellable>()
    private let dateFormater = DateFormatter(dateFormat: "MMM-dd-yyyy")

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PagesViewModel()
        self.tableView.register(UINib(nibName: "PageCell", bundle: nil), forCellReuseIdentifier: "PageCell")
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.viewModel.reload()
        self.bind()
    }

    func bind() {
        viewModel.$pages
            .receive(on: DispatchQueue.main)
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

extension PagesViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pages?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let page = viewModel.pages?[indexPath.row] else { return }
        if let pageVC = UIStoryboard(name: "PageDetail", bundle: nil)
            .instantiateViewController(withIdentifier: "CaseStudyPageDetailID") as? PageViewController {
            pageVC.slug = page.slug
            self.navigationController?.show(pageVC, sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PageCell", for: indexPath) as? PageCell,
              let page = viewModel.pages?[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.title.text = page.title
        cell.reviewedBy.text = page.reviewedBy
        if let url = URL(string: page.imageLink) {
            cell.pageImage.af.setImage(
            withURL: url,
            placeholderImage: UIImage(named: "img_page_featured"),
            filter: nil,
            imageTransition: UIImageView.ImageTransition.crossDissolve(0.5),
            runImageTransitionIfCached: false) { response in
                    if response.response != nil {
                        self.tableView.beginUpdates()
                        self.tableView.endUpdates()
                    }
            }
        }
        cell.studyDate.text = page.studyDate
        return cell
    }
}
