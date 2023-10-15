//
//  TableViewController.swift
//  UserPreferences
//
//  Created by Admin on 15.10.23.
//

import UIKit
import SnapKit

class TableViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(TableCell.self, forCellReuseIdentifier: TableCell.identifier)
        tableView.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
    }
    
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CollectionViewController.selectedCars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as? TableCell else { return UITableViewCell() }
        
        cell.configure(withText: CollectionViewController.selectedCars[indexPath.row])
        
        return cell
    }
    
    
}
