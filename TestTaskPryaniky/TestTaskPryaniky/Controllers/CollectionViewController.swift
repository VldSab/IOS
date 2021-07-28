//
//  CollectionViewController.swift
//  TestTaskPryaniky
//
//  Created by Владимир Гуль on 25.07.2021.
//

import UIKit
import SDWebImage

private var reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    let itemsPerRowAt: CGFloat = 1
    let marginSize: CGFloat = 20
    
    var viewArray = [String]()
    var allData = [DataModel]()
    var currentData = DataModel()
    
    var allDataMap: [String: DataModel] {
        var map = [String: DataModel]()
        for element in allData {
            map[element.name] = element
            print(element.selectedId)
        }
        return map
    }
    
    override func viewDidLoad() {
        getData()
        super.viewDidLoad()
    }
    
    //get data from parser
    func getData() {
        DataParser.dataParser.getArrayOfData { result in
            switch result {
            case .success(let dataItemsArray):
                self.allData = []
                self.allData = dataItemsArray.0
                self.viewArray = dataItemsArray.1
                self.refreshTable()
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
            }
        }
    }
    
    func refreshTable() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            return
        }
    }

    // MARK:- UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        reuseIdentifier = viewArray[indexPath.item]
        if reuseIdentifier == "hz" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! hzCollectionViewCell
            currentData = allDataMap[reuseIdentifier] ?? DataModel()
            cell.textHZLabel.text = currentData.text
            cell.backgroundColor = .green
            return cell
        } else if reuseIdentifier == "picture" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! pictureCollectionViewCell
            currentData = allDataMap[reuseIdentifier] ?? DataModel()
            cell.textPictureLabel.text = currentData.name
            let imageURL = URL(string: currentData.URL ?? "")
            cell.imageViewImage.sd_setImage(with: imageURL, completed: nil)
            cell.backgroundColor = .yellow
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! selectorCollectionViewCell
            currentData = allDataMap[reuseIdentifier] ?? DataModel()
            cell.selectorLabel.text = currentData.name
        
            guard currentData.variants!.count > 1 else {
                return cell
            }
            
            if let variant = currentData.variants?[0]["id"] as? Int {
                let stringVariant = String(variant)
                cell.selectorFirstButton.setTitle(stringVariant, for: .normal)
            }
            if let variant = currentData.variants?[1]["id"] as? Int {
                let stringVariant = String(variant)
                cell.selectorSecondButton.setTitle(stringVariant, for: .normal)
            }
            if let variant = currentData.variants?[2]["id"] as? Int {
                let stringVariant = String(variant)
                cell.selectorThirdButton.setTitle(stringVariant, for: .normal)
            }
            return cell
        }
    }
    
    //when item selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let identifier = viewArray[indexPath.item]
        
        if identifier == "hz" || identifier == "picture" {
           
            if let viewController = storyboard?.instantiateViewController(withIdentifier: "informationVC") as? InformationViewController {
                navigationController?.pushViewController(viewController, animated: true)
                
                if let labelText = allDataMap[identifier]?.text {
                    viewController.textForInformationLabel = labelText
                }
                
                if let imageURLString = allDataMap[identifier]?.URL {
                    let imageURL = URL(string: imageURLString)
                    viewController.image.sd_setImage(with: imageURL, completed: nil)
                }
            }
            
        } else {
            showAlert(with: "Sorry", and: "Please select right variant")
        }
    }
    
    // when one of the button has been tapped
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        guard let data = allDataMap["selector"] else {
            return
        }
        guard let id = data.selectedId else {
            return
        }
        if sender.tag == id  {
            if let viewController = storyboard?.instantiateViewController(withIdentifier: "informationVC") as? InformationViewController {
                
                guard let variants = data.variants?[id-1] as? [String: Any] else {
                    print("no variant")
                    return
                }
                
                navigationController?.pushViewController(viewController, animated: true)
                
                viewController.textForInformationLabel = variants["text"] as! String
            }
        } else {
            showAlert(with: "Sorry", and: "Please select right variant")
        }
    }
}

// MARK :- CollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = marginSize * (itemsPerRowAt + 1)
        let itemWidth: CGFloat = view.frame.width - paddingWidth
        let itemSize = CGSize(width: itemWidth, height: 0.5 * itemWidth)
        return itemSize
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layoutSubviews()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: marginSize, left: 10, bottom: marginSize, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return marginSize
    }
    
    //space between items in line
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return marginSize
    }
}
