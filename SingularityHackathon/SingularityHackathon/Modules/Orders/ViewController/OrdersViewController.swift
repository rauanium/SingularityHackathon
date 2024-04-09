//
//  OrdersViewController.swift
//  SingularityHackathon
//
//  Created by rauan on 4/8/24.
//

import UIKit

fileprivate typealias foodDataSource = UICollectionViewDiffableDataSource<Section, Int>
fileprivate typealias foodDataSourceSnapShot = NSDiffableDataSourceSnapshot<Section, Int>

class OrdersViewController: UIViewController {
    
    private var resource = [Int]()
    private var dataSource: foodDataSource!
    
    private lazy var compositionalLayout: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(OrdersCollectionViewCell.self,
            forCellWithReuseIdentifier: OrdersCollectionViewCell.identifier)
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createData()
        setupViews()
        configureDataSource()
    }

    private func setupViews() {
        
        view.backgroundColor = .background
        view.addSubview(compositionalLayout)
        navigationItem.title = "Orders"
        
        compositionalLayout.snp.makeConstraints { make in
            make.bottom.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
    }

}

extension OrdersViewController {
    private func createData() {
        for i in 0...10{
            resource.append(i)
        }
    }
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.35)
            ),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 8, leading: 8, bottom: 0, trailing: 8)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension OrdersViewController {
    private func configureDataSource() {
        dataSource = foodDataSource(collectionView: compositionalLayout) { (collectionView, indexPath, itemIdentifier) -> OrdersCollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OrdersCollectionViewCell.identifier,
                for: indexPath) as! OrdersCollectionViewCell
            return cell
        }
        applySnapshot()
        
    }
    private func applySnapshot() {
        var snapshot = foodDataSourceSnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.resource)
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
}
