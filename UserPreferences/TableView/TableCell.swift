//
//  tableCell.swift
//  UserPreferences
//
//  Created by Admin on 15.10.23.
//

import UIKit
import SnapKit

class TableCell: UITableViewCell {

    static let identifier = "TableCell"
    
    private let labelCarName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.textColor = .blue
        return lbl
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(labelCarName)
        labelCarName.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
    }
    
    public func configure(withText text: String) {
        labelCarName.text = text
    }

}
