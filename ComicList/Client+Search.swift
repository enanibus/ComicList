//
//  Client+Search.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 09/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import ComicService
import ComicContainer

import RxSwift

extension Client {

    func searchResults(forQuery query: String, page: Int) -> Observable<[Volume]> {
        return objects(forResource: API.search(query: query, page: page))
    }
}
