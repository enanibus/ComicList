//
//  SearchResultsViewModel.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 03/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import RxSwift

import ComicService
import ComicContainer

protocol SearchResultsViewModelType: class {

    /// The search query
    var query: String { get }

    /// Called after a new page of results has been loaded
    var didLoadPage: () -> Void { get set }

    /// The current number of search results
    var numberOfItems: Int { get }

    /// Returns the volume at a given position
    func item(at position: Int) -> Volume

    /// Loads the first page of results
    ///
    /// - parameter trigger: An observable that will trigger loading the next page
    ///
    /// - returns: An observable that will send the number of pages loaded
    func load(nextPage trigger: Observable<Void>) -> Observable<Int>
}

final class SearchResultsViewModel: SearchResultsViewModelType {

    let query: String
    var didLoadPage: () -> Void = {}

    public var numberOfItems: Int {
        return results.numberOfVolumes
    }

    public func item(at position: Int) -> Volume {
        return results.volume(at: position)
    }

    public func load(nextPage trigger: Observable<Void>) -> Observable<Int> {
        return doLoad(page: 1, nextPage: trigger)
    }

    private let client: Client
    private let container: VolumeContainerType
    private let results: VolumeResultsType
    private let disposeBag = DisposeBag()

    init(query: String,
         client: Client = Client(),
         container: VolumeContainerType = VolumeContainer.temporary()) {
        self.query = query
        self.client = client
        self.container = container

        container.load()
            .subscribe()
            .addDisposableTo(disposeBag)

        results = container.all()
        results.didUpdate = { [weak self] in
            self?.didLoadPage()
        }
    }

    private func doLoad(page current: Int, nextPage trigger: Observable<Void>) -> Observable<Int> {

        let container = self.container

        return client.searchResults(forQuery: query, page: current)
            .do(onNext: { _ in
                print("page: \(current)")
            })
            .flatMap { volumes in
                return container.save(volumes: volumes)
            }
            .flatMap { [unowned self] _ in
                return Observable.concat([
                    Observable.just(current),
                    Observable.never().takeUntil(trigger),
                    self.doLoad(page: (current + 1), nextPage: trigger)
                ])
            }
    }
}
