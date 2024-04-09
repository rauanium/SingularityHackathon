//
//  ReportViewController.swift
//  SingularityHackathon
//
//  Created by rauan on 4/8/24.
//

import UIKit


fileprivate typealias foodDataSource = UICollectionViewDiffableDataSource<Section, Int>
fileprivate typealias foodDataSourceSnapShot = NSDiffableDataSourceSnapshot<Section, Int>

class ReportViewController: UIViewController {
    
    private var resource = [Int]()
    private var dataSource: foodDataSource!
    
    private lazy var startDateStack: UIStackView = {
        let startDateStack = UIStackView()
        startDateStack.axis = .horizontal
        startDateStack.distribution = .equalSpacing
//        startDateStack.alignment = .center
//        startDateStack.backgroundColor = .yellow
        startDateStack.layer.cornerRadius = 4
         
        return startDateStack
    }()
    
    private lazy var startDateLabel: UILabel = {
        let startDate = UILabel()
        startDate.text = "from:"
        startDate.font = UIFont.systemFont(ofSize: 16)
        return startDate
    }()
    
    private lazy var startDate: UIDatePicker = {
        let startDate = UIDatePicker()
        startDate.datePickerMode = .date
        return startDate
        
    }()
    
    private lazy var endDateStack: UIStackView = {
        let totalStack = UIStackView()
        totalStack.axis = .horizontal
        totalStack.distribution = .equalSpacing
//        totalStack.alignment = .center
//        totalStack.backgroundColor = .brown
        return totalStack
    }()
    
    private lazy var endDateLabel: UILabel = {
        let startDate = UILabel()
        startDate.text = "to:"
        startDate.font = UIFont.systemFont(ofSize: 16)
        return startDate
    }()
    
    private lazy var endDate: UIDatePicker = {
        let startDate = UIDatePicker()
        startDate.datePickerMode = .date
        return startDate
        
    }()
    private lazy var filterStack: UIStackView = {
        let filterStack = UIStackView()
        filterStack.axis = .horizontal
        filterStack.distribution = .fillEqually
//        filterStack.alignment = .center
        filterStack.spacing = 16
        filterStack.backgroundColor = .white
        filterStack.layer.cornerRadius = 4
        return filterStack
    }()
    
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
        navigationItem.title = "Report"
        
        [filterStack, compositionalLayout].forEach {
            view.addSubview($0)
        }
        
        [startDateLabel, startDate].forEach {
            startDateStack.addArrangedSubview($0)
        }
        
        [endDateLabel, endDate].forEach {
            endDateStack.addArrangedSubview($0)
        }
        [startDateStack, endDateStack].forEach {
            filterStack.addArrangedSubview($0)
        }
        
        startDateStack.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(8)
        }
        endDateStack.snp.makeConstraints { make in
            
        }
        filterStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        compositionalLayout.snp.makeConstraints { make in
            make.top.equalTo(filterStack.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension ReportViewController {
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
                heightDimension: .fractionalHeight(0.39)
            ),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 8, leading: 8, bottom: 0, trailing: 8)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension ReportViewController {
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
