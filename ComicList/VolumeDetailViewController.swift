//
//  VolumeDetailViewController.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 02/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit
import RxSwift

import ComicContainer

/// Displays the details about a volume
class VolumeDetailViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var headerView: VolumeHeaderView!
    @IBOutlet private weak var aboutView: VolumeAboutView!
    @IBOutlet private weak var issuesView: VolumeIssuesView!

    // MARK: - Properties

    var didFinish: () -> Void = {}

    private let viewModel: VolumeDetailViewModelType
    private let disposeBag = DisposeBag()

    // MARK: - Initialization

    init(viewModel: VolumeDetailViewModelType) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    convenience init(volume: Volume) {
        self.init(viewModel: VolumeDetailViewModel(volume: volume))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupBindings()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if isMovingFromParentViewController || isBeingDismissed {
            didFinish()
        }
    }
    
    // MARK: - Private

    private func setupView() {
        view.backgroundColor = UIColor(named: .detailBackground)
    }

    private func setupBindings() {
        // Bind header

        let volume = viewModel.volume

        headerView.title = volume.title
        headerView.publisher = volume.publisherName
        headerView.coverURL = volume.coverURL

        viewModel.isSaved
            .bindTo(headerView.isSaved)
            .addDisposableTo(disposeBag)

        headerView.didTapButton = viewModel.addOrRemove

        // Bind about

        viewModel.about
            .bindTo(aboutView.about)
            .addDisposableTo(disposeBag)

        viewModel.about
            .map { $0?.isEmpty ?? true }
            .bindTo(aboutView.rx.hidden)
            .addDisposableTo(disposeBag)

        // Bind issues

        viewModel.issues
            .bindTo(issuesView.collectionView.rx.items) { collectionView, item, issue in

                let cell: ItemCell = collectionView.dequeueReusableCell(for: item)
                cell.titleLabel.text = issue.title
                cell.coverView.url = issue.coverURL

                return cell
            }
            .addDisposableTo(disposeBag)

        viewModel.issues
            .map { $0.isEmpty }
            .bindTo(issuesView.rx.hidden)
            .addDisposableTo(disposeBag)
    }
}
