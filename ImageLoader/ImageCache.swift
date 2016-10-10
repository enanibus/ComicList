//
//  ImageCache.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 01/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit

/// Represents a cache of images
public protocol ImageCache: class {

    /// Returns the image associated with a given URL
    func image(for url: URL) -> UIImage?

    /// Sets the image of the specified URL in the cache.
    func setImage(_ image: UIImage, for url: URL)
}
