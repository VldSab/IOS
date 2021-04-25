//
//  PhotosCollectionViewController.swift
//  PhotoCollection
//
//  Created by Владимир Гуль on 23.04.2021.
//

import UIKit


class PhotosCollectionViewController: UICollectionViewController {

    let photos = ["officeapple", "amazonoffice", "officegoogle", "officeyandex", "officenetflix"]
    let itemsPerRow : CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sharePhotoSegue"{
            let photoView = segue.destination as! PhotoViewController
            let cell = sender as! PhotoCell
            photoView.image = cell.imageView.image
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        let image = UIImage(named: photos[indexPath.item])
        cell.imageView.image = image
        return cell
    }
}

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //dinamic calculation items size
        let paddingsSpace = sectionInserts.left * (itemsPerRow + 1)
        let itemWidth = (collectionView.frame.width - paddingsSpace) / itemsPerRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    //section indent
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    //space between lines
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    //space between items in line
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
