//
//  RMSearchOptionsPickerVC.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 21.05.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class RMSearchOptionsPickerVC: BaseVC<RMSearchOptionsPickerVM> {
    var options: SearchInputViewVM.DynamicOptions?
    var selectionBlock: ((String) -> Void)?
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topNavBar.isHidden = true
        view.addSubview(tableView)
        addConstraints()
        bindTableView()
    }
    
    private func bindTableView() {
        ///tableview set datasource
        Observable.from(optional: options?.choies).asObservable().bind(to: self.tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self), curriedArgument: { row, item, cell in
            cell.textLabel?.text = item.uppercased()
        }).disposed(by: disposeBag)
        ///tableview set delegate
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self).bind { model in
            if let selectionBlock = self.selectionBlock {
                selectionBlock(model)
            }
            self.dismiss(animated: true)
        }.disposed(by: disposeBag)
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
        ])
    }
}

extension RMSearchOptionsPickerVC: UITableViewDelegate {
}
