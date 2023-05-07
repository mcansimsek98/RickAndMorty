//
//  RMLocationVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 27.02.2023.
//

import UIKit
import RxSwift
import RxDataSources

class RMLocationVC: BaseVC<RMLocationVM> {
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(LocationTVCell.self, forCellReuseIdentifier: LocationTVCell.identifier)
        tv.backgroundColor = .clear
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        return tv
    }()
    
    private var dataSource = RxTableViewSectionedAnimatedDataSource<DataSourceModel<LocationTVCellVM>>(
        configureCell: { dataSource, tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTVCell.identifier, for: indexPath) as? LocationTVCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = UIColor(named: "DarkGrey")?.withAlphaComponent(0.5)
            cell.configure(with: item)
            return cell
        })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getAllLocation()
        bindViewModel()
    }
    
    override func setUpView() {
        self.topNavBar.title.text = ViewTitle.location
        topNavBar.hasBackButton = false
        topNavBar.searchBtn.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    @objc
    private func didTapSearch() {
        self.viewModel.searchAction.onNext(.init(type: .location))
    }
}

extension RMLocationVC: UITableViewDelegate {
    func bindViewModel() {
        ///tableview set datasource
        viewModel.allLocationList
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        ///tableview set delegate
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        ///tableview pagination
        tableView.rx.contentOffset
            .asDriver()
            .drive(onNext: { [weak self] offset in
                guard let self = self else { return }
                if self.tableView.isNearBottomEdge(edgeOffset: 20.0), self.viewModel.hasMoreResults, !self.viewModel.isLoadingMoreLocation {
                    guard let nextUrlString = self.viewModel?.apiInfo?.next else {
                        return
                    }
                    self.viewModel.fetchAdditionalLocation(url: nextUrlString)
                }
            })
            .disposed(by: disposeBag)
        
        ///tableview didselect
        Observable
            .zip(tableView.rx.itemSelected,
                 tableView.rx.modelSelected(LocationTVCellVM.self))
            .bind { [weak self] indexPath, model in
                self?.viewModel.gotoLocationDetail.onNext("\(model.locationId)")
            }.disposed(by: disposeBag)
    }
}
