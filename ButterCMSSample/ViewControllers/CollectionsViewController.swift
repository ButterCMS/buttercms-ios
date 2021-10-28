//
//  CollectionsViewController.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 14.09.2021.
//

import UIKit
import Combine

class CollectionsViewController: UITableViewController {
    private var viewModel: FaqCollectionViewModel!
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        self.viewModel = FaqCollectionViewModel()
        self.tableView.register(UINib(nibName: "CollectionItemCell", bundle: nil), forCellReuseIdentifier: "CollectionItemCell")
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        super.viewDidLoad()
        self.viewModel.reload()
        bind()
    }

    private func bind() {
        viewModel.$collection
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

extension CollectionsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.collection?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
       return "Faq"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionItemCell", for: indexPath) as? CollectionItemCell,
              let item = viewModel.collection?[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.question.text = item.question
        cell.answer.text = item.answer
        return cell
    }
}
