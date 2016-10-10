//
//  SearchSuggestionsViewController.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 29/09/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// Displays search suggestions
class SearchSuggestionsViewController: UITableViewController {

    // MARK: - Properties

    var didSelectSuggestion: (String) -> Void = { _ in }

    fileprivate let viewModel: SearchSuggestionsViewModelType

    fileprivate let disposeBag = DisposeBag()

    // MARK: - Initialization

    init(viewModel: SearchSuggestionsViewModelType = SearchSuggestionsViewModel()) {
        self.viewModel = viewModel
        super.init(style: .plain)
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

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }

    // MARK: - Private

    private func setupView() {
        tableView.backgroundColor = UIColor(named: .background).withAlphaComponent(0.3)
        tableView.tableFooterView = UIView()

        let effect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: effect)

        tableView.backgroundView = blurView
        tableView.separatorEffect = UIVibrancyEffect(blurEffect: effect)

        tableView.register(UITableViewCell.self)
    }

    private func setupBindings() {
        tableView.dataSource = nil

        // Bind the suggestions to the table view data source
        viewModel.suggestions
            .bindTo(tableView.rx.items) { tableView, index, suggestion in
                let cell: UITableViewCell = tableView.dequeueReusableCell()
                cell.textLabel?.text = suggestion

                return cell
            }
            .addDisposableTo(disposeBag)

        // When a suggestion is selected we need to call `didSelectSuggestion`
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext: { [weak self] suggestion in
                self?.didSelectSuggestion(suggestion)
            })
            .addDisposableTo(disposeBag)
    }
}

// MARK: - UISearchResultsUpdating

extension SearchSuggestionsViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        // As the user types we need to update the search query
        viewModel.query.value = searchController.searchBar.text ?? ""
    }
}

