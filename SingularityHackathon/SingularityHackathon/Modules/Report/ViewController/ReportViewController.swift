//
//  ReportViewController.swift
//  SingularityHackathon
//
//  Created by rauan on 4/8/24.
//

import UIKit


fileprivate typealias foodDataSource = UICollectionViewDiffableDataSource<Section, OrdersDataModel>
fileprivate typealias foodDataSourceSnapShot = NSDiffableDataSourceSnapshot<Section, OrdersDataModel>

class ReportViewController: UIViewController {
    
    private var viewModel: ReportViewModel?
    private var orders = [OrdersDataModel]()
    private var dataSource: foodDataSource!
    let formatter = DateFormatter()
    private var startDay = "10/04/2024"
    private var endDay = "11/04/2024"
    private lazy var startDateStack: UIStackView = {
        let startDateStack = UIStackView()
        startDateStack.axis = .horizontal
        startDateStack.distribution = .equalSpacing
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
        let endDateStack = UIStackView()
        endDateStack.axis = .horizontal
        endDateStack.distribution = .equalSpacing
        return endDateStack
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
        endDate.addTarget(self, action: #selector(didTapEndDate), for: .valueChanged)
        return endDate
        
    }()
    private lazy var filterStack: UIStackView = {
        let filterStack = UIStackView()
        filterStack.axis = .horizontal
        filterStack.distribution = .fillEqually
        filterStack.spacing = 16
        filterStack.backgroundColor = .white
        filterStack.layer.cornerRadius = 4
        return filterStack
    }()
    
    private lazy var totalStack: UIStackView = {
        let totalStack = UIStackView()
        totalStack.axis = .horizontal
        totalStack.distribution = .equalSpacing
        return totalStack
    }()
    
    private lazy var totalLabel: UILabel = {
        let totalLabel = UILabel()
        totalLabel.text = "Total:"
        totalLabel.font = UIFont.systemFont(ofSize: 18)
        return totalLabel
    }()
    
    private lazy var totalValue: UILabel = {
        let totalValue = UILabel()
        totalValue.text = ""
        totalValue.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return totalValue
    }()
    
    private lazy var countStack: UIStackView = {
        let countStack = UIStackView()
        countStack.axis = .horizontal
        countStack.distribution = .equalSpacing
        return countStack
    }()
    
    private lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.text = "Count:"
        countLabel.font = UIFont.systemFont(ofSize: 18)
        return countLabel
    }()
    
    private lazy var countValue: UILabel = {
        let countValue = UILabel()
        countValue.text = ""
        countValue.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return countValue
    }()
    private lazy var countAndTotalStack: UIStackView = {
        let countAndTotalStack = UIStackView()
        countAndTotalStack.axis = .vertical
        countAndTotalStack.distribution = .equalSpacing
        countAndTotalStack.backgroundColor = .white
        countAndTotalStack.layer.cornerRadius = 4
        return countAndTotalStack
    }()
    
    private lazy var compositionalLayout: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(ReportCollectionViewCell.self,
            forCellWithReuseIdentifier: ReportCollectionViewCell.identifier)
        return collectionView
        
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        createData()
        setupViews()
        configureDataSource()
        setupViewModel()
    }
    
    //MARK: - Setting up views
    private func setupViews() {
        
        view.backgroundColor = .background
        navigationItem.title = "Report"
        
        [filterStack, compositionalLayout, countAndTotalStack].forEach {
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
        [totalStack, countStack].forEach {
            countAndTotalStack.addArrangedSubview($0)
        }
        
        [countLabel, countValue].forEach {
            countStack.addArrangedSubview($0)
        }
        
        [totalLabel, totalValue].forEach {
            totalStack.addArrangedSubview($0)
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
        countAndTotalStack.snp.makeConstraints { make in
            make.top.equalTo(filterStack.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        
        compositionalLayout.snp.makeConstraints { make in
            make.top.equalTo(countAndTotalStack.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupViewModel() {
        viewModel = ReportViewModel()
        
        viewModel?.getReports(start: startDay, end: endDay, completion: { [weak self] result in
            self?.orders = result
        })
          
        var total = 0
        orders.forEach { price in
            total += Int(price.foodPrce)!
        }
        
        totalValue.text = "\(total)T"
        countValue.text = "\(orders.count)"
        
        self.applySnapshot()
        }
        
    
    
    @objc
    private func didTapStartDate(sender: UIDatePicker) {
        
        formatter.dateFormat = "dd/MM/yyyy"
        startDay = formatter.string(from: sender.date)
        print("date: \(formatter.string(from: sender.date))")
        presentedViewController?.dismiss(animated: false, completion: nil)
        setupViewModel()
    }
    
    @objc
    private func didTapEndDate(sender: UIDatePicker) {
        
        formatter.dateFormat = "dd/MM/yyyy"
        endDay = formatter.string(from: sender.date)
        print("date: \(formatter.string(from: sender.date))")
        presentedViewController?.dismiss(animated: false, completion: nil)
    }

}

extension ReportViewController {
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
                heightDimension: .fractionalHeight(0.33)
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
            cell.configure(data: self.orders[indexPath.row])
            return cell
        }
        applySnapshot()
        
    }
    
    private func applySnapshot() {
        var snapshot = foodDataSourceSnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.orders)
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
}
