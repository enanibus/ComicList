//
//  VolumeIssuesView.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 03/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit

final class VolumeIssuesView: UIView {

    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = NSLocalizedString("ISSUES", comment: "")
            titleLabel.textColor = UIColor(named: .darkText)
        }
    }

    @IBOutlet private(set) weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = UIColor(named: .detailBackground)
            collectionView.register(ItemCell.self)
        }
    }
}
