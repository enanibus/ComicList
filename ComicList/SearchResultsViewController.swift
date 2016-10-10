//
//  SearchResultsViewController.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 03/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit
import RxSwift

import ComicContainer

/// Displays the search results for a given query
final class SearchResultsViewController: UITableViewController {

    // MARK: - Properties

    var didSelectVolume: (Volume) -> Void = { _ in }
    var didFinish: () -> Void = {}

    private let viewModel: SearchResultsViewModelType
    private let nextPage = PublishSubject<Void>()
    private let disposeBag = DisposeBag()

    // MARK: - Initialization

    init(viewModel: SearchResultsViewModelType) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }

    convenience init(query: String) {
        self.init(viewModel: SearchResultsViewModel(query: query))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupBindings()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if isMovingFromParentViewController || isBeingDismissed {
            didFinish()
        }
    }
    
    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchResultCell = tableView.dequeueReusableCell(for: indexPath)
        let volume = viewModel.item(at: indexPath.row)

        cell.coverView.url = volume.coverURL
        cell.titleLabel.text = volume.title
        cell.publisherLabel.text = volume.publisherName

        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear

        let index = indexPath.row
        let maxIndex = tableView.numberOfRows(inSection: 0) - 1

        // Load the next page when we are about to display the last cell
        if index == maxIndex {
            nextPage.onNext()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let volume = viewModel.item(at: indexPath.row)
        didSelectVolume(volume)
    }
    
    // MARK: - Private

    private func setupView() {
        title = viewModel.query

        tableView.rowHeight = 88
        tableView.backgroundColor = UIColor(named: .background)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 0)
        tableView.tableFooterView = UIView()
        
        tableView.register(SearchResultCell.self)
    }

    private func setupBindings() {
        // Reload our table view when a new page is loaded
        viewModel.didLoadPage = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.load(nextPage: nextPage.asObservable())
            .subscribe()
            .addDisposableTo(disposeBag)
    }
}
