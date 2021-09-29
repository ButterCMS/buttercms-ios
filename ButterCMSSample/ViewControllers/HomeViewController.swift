//
//  HomeController.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 14.09.2021.
//

import UIKit
import Combine

class HomeViewController: UITableViewController {
    private var viewModel: HomeViewModel!
    private let homeHeaderCellId = "HomeHeaderCell"
    private var subscriotions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HomeTitleCell", bundle: nil), forCellReuseIdentifier: "HomeTitleCell")
        tableView.register(UINib(nibName: "HomeSectionCell", bundle: nil), forCellReuseIdentifier: "HomeSectionCell")

        viewModel = HomeViewModel()
        bind()
        viewModel.setupOutput()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func bind() {
        viewModel.$homePage.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.tableView.reloadData()
        }.store(in: &subscriotions)

        viewModel.errorMessage.receive(on: DispatchQueue.main).sink { [weak self] message in
            let alert = UIAlertController(title: "Error!", message: message, preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in }
            alert.addAction(alertAction)
            self?.present(alert, animated: true) {
                () -> Void in
            }
        }.store(in: &subscriotions)
    }
}

extension HomeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.homePage?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = TableViewASectionType(rawValue: section),
            let sec = viewModel.homePage?[sectionType] else { return 0 }
        return sec.count
    }

    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = TableViewASectionType(rawValue: indexPath.section) else { return UITableViewCell() }
        switch sectionType {
        case .header:
            guard let homePageHeder = viewModel.homePage?[sectionType]?.first as? HomePageHeader,
                  let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTitleCell", for: indexPath) as? HomeTitleCell else {
                return UITableViewCell()
            }
            cell.headerTitle.text = homePageHeder.headline
            cell.headerSubTitle.text = homePageHeder.subheadline
            return cell
        case .sections:
            guard let homeSection = viewModel.homePage?[sectionType]?[indexPath.row] as? Section,
                  let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSectionCell", for: indexPath) as? HomeSectionCell else {
                return UITableViewCell()
            }
            
            cell.title.text = homeSection.title
            cell.subTitle.text = homeSection.subtitle
            cell.url = homeSection.buttonurl
            cell.learnButtonClicked.sink { url in
                    let webView = WebViewControllew(url: url)
                    self.show(webView, sender: self)
            }
            .store(in: &subscriotions)
            cell.buttonClicked.sink { _ in
                switch homeSection.title {
                case "Blog Engine":
                    self.tabBarController?.selectedIndex = 1
                case "Pages":
                    self.tabBarController?.selectedIndex = 2
                case "Collections":
                    self.tabBarController?.selectedIndex = 3
                default:
                    break
                }

            }
            .store(in: &subscriotions)
            return cell
        case .docUrl:
            return UITableViewCell()
        }
    }
}
