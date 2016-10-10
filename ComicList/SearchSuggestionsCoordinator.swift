//
//  SearchSuggestionsCoordinator.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 29/09/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit

/// Coordinates the presentation of the search UI
final class SearchSuggestionsCoordinator: Coordinator {

    var didSelectSuggestion: (String) -> Void = { _ in }
    var searchButtonClicked: (String) -> Void = { _ in }

    private unowned let navigationItem: UINavigationItem
    private let searchController: UISearchController

    init(navigationItem: UINavigationItem) {
        self.navigationItem = navigationItem

        let viewController = SearchSuggestionsViewController()
        searchController = UISearchController(searchResultsController: viewController)

        super.init()

        viewController.didSelectSuggestion = { [weak self] suggestion in
            self?.didSelectSuggestion(suggestion)
        }

        searchController.searchResultsUpdater = viewController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self

        searchController.searchBar.placeholder = NSLocalizedString("Search Comic Vine", comment: "")
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.searchFieldTextColor = UIColor.white
        searchController.searchBar.keyboardAppearance = .dark
    }

    override func start() {
        navigationItem.titleView = searchController.searchBar
    }
}

extension SearchSuggestionsCoordinator: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text ?? ""

        if !text.isEmpty {
            searchButtonClicked(text)
        }
    }
}
