//
//  UIViewController+Extensions.swift
//  GuTock
//
//  Created by Владимир Гуль on 14.05.2021.
//

import UIKit

extension UIViewController {
    
    func configure<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T  else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: value)
        return cell
    }
    
}
