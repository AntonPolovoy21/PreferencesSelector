//
//  PreferenceCell.swift
//  UserPreferences
//
//  Created by Admin on 15.10.23.
//

import UIKit

class PreferenceCell: UICollectionViewCell {

    static let identifier = "PreferenceCell"
    
    public var wasSelected = false
    
    private let borderView: UIView = {
        let view = UILabel()
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    private let bgView = UIImageView()
    
    private let carNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont(name: "Optima", size: 22)
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    
    private let selectLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 45)
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(borderView)
        borderView.snp.makeConstraints() {
            $0.top.right.bottom.left.equalToSuperview()
        }
        
        let padding = 2
        borderView.addSubview(bgView)
        bgView.snp.makeConstraints() {
            $0.top.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().offset(-padding)
            $0.bottom.equalToSuperview().offset(-padding)
            $0.left.equalToSuperview().offset(padding)
        }
        
        bgView.addSubview(carNameLabel)
        bgView.clipsToBounds = true
        carNameLabel.snp.makeConstraints() {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        bgView.addSubview(selectLabel)
        selectLabel.snp.makeConstraints() {
            $0.center.equalToSuperview()
        }
    }
    
    public func configure(withCarName name: String) {
        carNameLabel.text = name
        bgView.image = UIImage(named: name)
        bgView.layer.borderColor = UIColor.red.cgColor
        bgView.layer.cornerRadius = 30
    }
    
    public func selectCell() {
        
        CollectionViewController.numberOfSelected += 1
        bgView.layer.opacity = 0.75
        borderView.backgroundColor = .white
        selectLabel.text = "✔︎"
        wasSelected = true
        CollectionViewController.selectedCars.append(carNameLabel.text ?? "Default")
    }
    
    public func deselectCell() {
        
        CollectionViewController.numberOfSelected -= 1
        bgView.layer.opacity = 1.0
        borderView.backgroundColor = .clear
        selectLabel.text = ""
        wasSelected = false
        CollectionViewController.selectedCars.removeAll(where: { $0 == carNameLabel.text })
    }
}
