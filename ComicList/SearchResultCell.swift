//
//  SearchResultCell.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 03/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var coverView: CoverView!

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = UIColor(named: .darkText)
        }
    }

    @IBOutlet weak var publisherLabel: UILabel! {
        didSet {
            publisherLabel.textColor = UIColor(named: .lightText)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        coverView.url = nil
    }
}
