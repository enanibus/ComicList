//
//  Volume.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 02/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

/// A comic volume
public struct Volume {

    /// Unique identifier
    public let identifier: Int

    /// Volume title
    public let title: String

    /// Cover image URL
    public let coverURL: URL?

    /// Publisher name
    public let publisherName: String?

    public init(identifier: Int,
                title: String,
                coverURL: URL?,
                publisherName: String?) {
        self.identifier = identifier
        self.title = title
        self.coverURL = coverURL
        self.publisherName = publisherName
    }
}

extension Volume {

    internal init(entry: VolumeEntry) {
        self.identifier = entry.identifier
        self.title = entry.title
        self.coverURL = entry.coverURL
        self.publisherName = entry.publisher
    }
}
