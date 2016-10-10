//
//  RemoteImageLoader.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 02/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit
import HTTPFetcher
import RxSwift

/// Loads remote images, storing them in a memory cache
public final class RemoteImageLoader: ImageLoader {

    public static let instance: ImageLoader = RemoteImageLoader(
        cache: MemoryImageCache(),
        fetcher: URLSession(configuration: URLSessionConfiguration.default)
    )

    private let cache: ImageCache
    private let fetcher: HTTPFetcher

    init(cache: ImageCache, fetcher: HTTPFetcher) {
        self.cache = cache
        self.fetcher = fetcher
    }

    public func image(for url: URL) -> Observable<UIImage?> {
        // If the image is already in the cache, just return it
        if let image = cache.image(for: url) {
            return Observable.just(image)
        }

        // Otherwise, we have to fetch the data for the corresponding URL
        return fetcher.data(request: URLRequest(url: url))
            // Map the data to an actual image. `UIImage.init` will return
            // `nil` if the data cannot be parsed
            .map { UIImage(data: $0) }
            // Store the image in the cache
            .do(onNext: { image in
                if let image = image {
                    self.cache.setImage(image, for: url)
                }
            })
            // Return `nil` on error
            .catchErrorJustReturn(nil)
            // Make sure the image is delivered in the main thread
            .observeOn(MainScheduler.instance)
    }
}
