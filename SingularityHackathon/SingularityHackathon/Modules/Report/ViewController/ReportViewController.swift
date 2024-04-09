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
        let startDateLabel = UILabel()
        startDateLabel.text = "from:"
        startDateLabel.font = UIFont.systemFont(ofSize: 16)
        return startDateLabel
    }()
    
    private lazy var startDate: UIDatePicker = {
        let startDate = UIDatePicker()
        startDate.datePickerMode = .date
        
        startDate.addTarget(self, action: #selector(didTapStartDate), for: .valueChanged)
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
        let endDateLabel = UILabel()
        endDateLabel.text = "to:"
        endDateLabel.font = UIFont.systemFont(ofSize: 16)
        return endDateLabel
    }()
    
    private lazy var endDate: UIDatePicker = {
        let endDate = UIDatePicker()
        endDate.datePickerMode = .date
        return endDate
        
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
        collectionView.register(ReportCollectionViewCell.self,
            forCellWithReuseIdentifier: ReportCollectionViewCell.identifier)
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
    @objc
    private func didTapStartDate(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        print("date: \(formatter.string(from: sender.date))")
        presentedViewController?.dismiss(animated: false, completion: nil)
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
                heightDimension: .fractionalHeight(0.31)
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
        dataSource = foodDataSource(collectionView: compositionalLayout) { (collectionView, indexPath, itemIdentifier) -> ReportCollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReportCollectionViewCell.identifier,
                for: indexPath) as! ReportCollectionViewCell
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
