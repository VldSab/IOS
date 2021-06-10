//
//  PhotosCollectionViewController.swift
//  PhotoCollection
//
//  Created by Владимир Гуль on 23.04.2021.
//

import UIKit
import SDWebImage

class PhotosCollectionViewController: UICollectionViewController {
    
    let numberOfFilms = 6
    let itemsPerRow : CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    var filmsStruct = FilmStruct(title: "", ratingIMDB: 0, description: "", posterURLString: "")
    var allFilms = [FilmStruct]()
    var arrayOfFilmsDicts = Array<[String:Any]>()
    
    override func viewDidLoad() {
        getFilms()
        super.viewDidLoad()
        
    }
    
    lazy var kinopoiskParser = KinopoiskParser()
    
    
    func getFilms() {
        kinopoiskParser.getArrayOfFilms { result in
            switch result {
            case .success(let arrayOfFilms):
                self.allFilms.append(contentsOf: arrayOfFilms)
                self.refreshTable()
                for film in self.allFilms {
                    print(film.title)
                }
                self.refreshTable()
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
                
            }
        }
    }
    
    func refreshTable(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sharePhotoSegue"{
            let photoView = segue.destination as! PhotoViewController
            let cell = sender as! PhotoCell
            photoView.image = cell.imageView.image
            photoView.text = cell.text
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFilms.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        guard let posterURL = URL(string: "https:" + allFilms[indexPath.row].posterURLString) else {
            return cell
        }
        cell.text = allFilms[indexPath.row].description
        cell.imageView.sd_setImage(with: posterURL, completed: nil)
        return cell
    }
}

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //dinamic calculation items size
        let paddingsSpace = sectionInserts.left * (itemsPerRow + 1)
        let itemWidth = (collectionView.frame.width - paddingsSpace) / itemsPerRow
        return CGSize(width: itemWidth, height: itemWidth + 1/2 * itemWidth)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
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
