//
//  ViewController.swift
//  SingularityHackathon
//
//  Created by rauan on 4/8/24.
//

import UIKit
import SnapKit

fileprivate typealias foodDataSource = UICollectionViewDiffableDataSource<MenuSection, Int>
fileprivate typealias foodDataSourceSnapShot = NSDiffableDataSourceSnapshot<MenuSection, Int>

class MenuViewController: UIViewController {
    
    private var resource = [Int]()
    private var dataSource: foodDataSource!
    
    private lazy var compositionalLayout: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(MenuCollectionViewCell.self,
            forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
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
        
        compositionalLayout.snp.makeConstraints { make in
            make.bottom.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
    }

}

extension MenuViewController {
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
        item.contentInsets = .init(top: 16, leading: 8, bottom: 8, trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(0.5)),
            repeatingSubitem: item,
            count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: 8, bottom: 0, trailing: 8)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension MenuViewController {
    private func configureDataSource() {
        dataSource = foodDataSource(collectionView: compositionalLayout) { (collectionView, indexPath, itemIdentifier) -> MenuCollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MenuCollectionViewCell.identifier,
                for: indexPath) as! MenuCollectionViewCell
            
            return cell
        }
        applySnapshot()
        
    }
    private func applySnapshot() {
        var snapshot = foodDataSourceSnapShot()
        snapshot.appendSections([.menu])
        snapshot.appendItems(self.resource)
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
}
