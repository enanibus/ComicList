//
//  SearchSuggestionsViewModel.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 29/09/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import RxSwift
import ComicService

/// Fetches suggestions for a given search query
protocol SearchSuggestionsViewModelType: class {

    /// The search query
    var query: Variable<String> { get }

    /// The search suggestions
    var suggestions: Observable<[String]> { get }
}

final class SearchSuggestionsViewModel: SearchSuggestionsViewModelType {

    let query = Variable("")

    private(set) lazy var suggestions: Observable<[String]> = self.query.asObservable()
        .filter { query in
            // Ignore query strings with less that 3 characters
            query.characters.count > 2
        }
        .throttle(0.3, scheduler: MainScheduler.instance)
        .flatMapLatest { query in
            return self.client.suggestedTitles(forQuery: query)
        }
        .observeOn(MainScheduler.instance)
        .shareReplay(1)

    private let client: Client

    init(client: Client = Client()) {
        self.client = client
    }
}
