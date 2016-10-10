//
//  ItemCell.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 02/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var coverView: CoverView!
    @IBOutlet weak var titleLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        coverView.url = nil
    }
}
