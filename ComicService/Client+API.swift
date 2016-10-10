//
//  Client+API.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 08/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import RxSwift

extension Client {

    public func suggestedTitles(forQuery query: String) -> Observable<[String]> {
        return suggestions(forQuery: query)
            .map { suggestions in
                var titles: [String] = []

                for suggestion in suggestions where !titles.contains(suggestion.title) {
                    titles.append(suggestion.title)
                }

                return titles
            }
    }

    public func suggestions(forQuery query: String) -> Observable<[Suggestion]> {
        return objects(forResource: API.suggestions(query: query))
    }
}
