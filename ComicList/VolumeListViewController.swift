//
//  VolumeListViewController.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 29/09/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit
import ComicContainer

/// Displays a list of comic volumes saved by the user
class VolumeListViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(ItemCell.self)
            collectionView.backgroundColor = UIColor(named: .background)
        }
    }

    /// Called when the user selects a volume
    var didSelectVolume: (Volume) -> Void = { _ in }

    fileprivate let viewModel: VolumeListViewModelType

    // MARK: - Initialization

    init(viewModel: VolumeListViewModelType = VolumeListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // We need to reload our collection view when the
        // comic list is updated
        viewModel.didUpdate = collectionView.reloadData
    }
}

// MARK: - UICollectionViewDataSource

extension VolumeListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfVolumes
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let volume = viewModel.item(at: indexPath.item)
        let cell: ItemCell = collectionView.dequeueReusableCell(for: indexPath)

        cell.coverView.url = volume.coverURL
        cell.titleLabel.text = volume.title

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension VolumeListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let volume = viewModel.item(at: indexPath.item)
        didSelectVolume(volume)
    }
}
