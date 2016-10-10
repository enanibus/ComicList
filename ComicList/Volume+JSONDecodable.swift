//
//  Volume+JSONDecodable.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 09/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import ComicContainer
import ComicService

extension Volume: JSONDecodable {

    public init?(dictionary: JSONDictionary) {
        guard
            let identifier = dictionary["id"] as? Int,
            let title = dictionary["name"] as? String else {
            return nil
        }

        self.identifier = identifier
        self.title = title
        self.publisherName = (dictionary as NSDictionary)
            .value(forKeyPath: "publisher.name") as? String
        self.coverURL = ((dictionary as NSDictionary)
            .value(forKeyPath: "image.small_url") as? String)
            .flatMap { URL(string: $0) }
    }
}
