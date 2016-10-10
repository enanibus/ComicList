//
//  VolumeListCoordinator.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 29/09/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit

/// Coordinates all the navigation originating from the comic list screen
final class VolumeListCoordinator: Coordinator {

    private unowned let navigationController: UINavigationController
    private let viewController: VolumeListViewController
    private let suggestionsCoordinator: SearchSuggestionsCoordinator

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        viewController = VolumeListViewController()
        suggestionsCoordinator = SearchSuggestionsCoordinator(navigationItem: viewController.navigationItem)

        super.init()

        // Present the detail when the user selects a volume
        viewController.didSelectVolume = { [weak self] volume in
            guard let `self` = self else {
                return
            }

            let coordinator = VolumeDetailCoordinator(volume: volume, navigationController: navigationController)
            self.add(child: coordinator)

            coordinator.start()
        }

        // Present the search results when the user selects a search suggestion
        suggestionsCoordinator.didSelectSuggestion = { [weak self] suggestion in
            self?.presentSearchResults(for: suggestion)
        }

        // Present the search results when the user taps on the search button
        suggestionsCoordinator.searchButtonClicked = { [weak self] text in
            self?.presentSearchResults(for: text)
        }
    }

    override func start() {
        viewController.definesPresentationContext = true
        navigationController.pushViewController(viewController, animated: false)

        suggestionsCoordinator.start()
    }

    private func presentSearchResults(for query: String) {
        let coordinator = SearchResultsCoordinator(
            query: query,
            navigationController: navigationController
        )

        add(child: coordinator)
        coordinator.start()
    }
}
