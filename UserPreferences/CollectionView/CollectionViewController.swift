//
//  ViewController.swift
//  UserPreferences
//
//  Created by Admin on 15.10.23.
//

import UIKit
import SnapKit

class CollectionViewController: UIViewController {
    
    private lazy var maxY = self.view.frame.maxY
    
    static var numberOfSelected = 0
    static var selectedCars = [String]()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let continueLabelSize = CGSize(width: 250, height: 60)
    private let continueLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Continue"
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = UIFont(name: "Optima", size: 30)
        lbl.backgroundColor = .black
        lbl.layer.cornerRadius = 30
        lbl.layer.borderWidth = 1
        lbl.layer.borderColor = UIColor.white.cgColor
        lbl.clipsToBounds = true
        return lbl
    }()
    
    private let carNames: [String] = ["Ferrari", "Lamborghini", "Porsche", "Tesla", "Audi",
                                       "BMW", "Mercedes-Benz", "Jaguar", "Lexus", "Maserati",
                                       "McLaren", "Bugatti", "Aston Martin", "Rolls-Royce"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        addViews()
    }

    private func addViews() {
        
        view.backgroundColor = .black
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints() {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(10)
            $0.right.equalTo(-10)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PreferenceCell.self, forCellWithReuseIdentifier: PreferenceCell.identifier)
        
        view.addSubview(continueLabel)
        continueLabel.frame = CGRect(x: view.frame.maxX / 2 - continueLabelSize.width / 2, y: self.maxY + continueLabelSize.height, width: continueLabelSize.width, height: continueLabelSize.height)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(submitPrefered))
        continueLabel.addGestureRecognizer(gestureRecognizer)
        continueLabel.isUserInteractionEnabled = true
    }
    
    public func showContinueLabel(withDuration duration: Double) {
        UIView.animate(withDuration: duration / 2, delay: 0.0, options: [.curveEaseIn], animations: { [self] in
            continueLabel.frame.origin.y = maxY - continueLabelSize.height * 2
        }, completion: { _ in
            UIView.animate(withDuration: duration / 2, delay: 0.0, options: [.curveEaseOut]) { [self] in
                continueLabel.frame.origin.y = maxY - continueLabelSize.height * 1.5
            }
        })
    }
    
    public func hideContinueLabel(withDuration duration: Double) {
        UIView.animate(withDuration: duration / 2, delay: 0.0, options: [.curveEaseIn]) { [self] in
            continueLabel.frame.origin.y = maxY + continueLabelSize.height
        }
    }
    
    @objc private func submitPrefered() {
        let vc = TableViewController()
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(navbarBack))
        backButton.tintColor = .systemBlue
        vc.navigationItem.leftBarButtonItem = backButton
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc private func navbarBack() {
        dismiss(animated: true)
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? PreferenceCell else { return }
        
        let prevNumberOfSelected = CollectionViewController.numberOfSelected
        cell.wasSelected ? cell.deselectCell() : cell.selectCell()
        
        guard prevNumberOfSelected == 0 && CollectionViewController.numberOfSelected == 1 else {
            guard prevNumberOfSelected == 1 && CollectionViewController.numberOfSelected == 0 else { return }
            hideContinueLabel(withDuration: 1.5)
            return
        }
        showContinueLabel(withDuration: 2.0)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return carNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreferenceCell.identifier, for: indexPath) as? PreferenceCell else { return UICollectionViewCell() }
        cell.configure(withCarName: carNames[indexPath.row])
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize = view.frame.width * 0.5 - 20
        return CGSize(width: cellSize, height: cellSize)
    }
}
