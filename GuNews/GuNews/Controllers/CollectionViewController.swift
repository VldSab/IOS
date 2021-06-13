//
//  CollectionViewController.swift
//  GuNews
//
//  Created by Владимир Гуль on 10.06.2021.
//

import UIKit
import SDWebImage


class CollectionViewController: UICollectionViewController {
    
    let itemsPerRowAt: CGFloat = 1
    let marginSize: CGFloat = 20
    
    var allNews = [NewsModel]()
    
    lazy var newsParser = NewsParser()
    
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsData()
        self.refresher = UIRefreshControl()
        self.refresher.tintColor = UIColor.systemGray
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        self.collectionView.refreshControl = refresher
    }
    
    @objc func loadData() {
        self.collectionView.refreshControl?.beginRefreshing()
        getNewsData()
        refreshTable()
        stopRefresher()         //Call this to stop refresher
     }

    func stopRefresher() {
        self.collectionView.refreshControl?.endRefreshing()
     }
    
    func getNewsData() {
        newsParser.getArrayOfNews { result in
            switch result {
            case .success(let newsArray):
                self.allNews = []
                self.allNews.append(contentsOf: newsArray)
                self.refreshTable()
                for elem in self.allNews {
                    print(elem.title)
                }
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
        if segue.identifier == "toArticle"{
            let articleView = segue.destination as! ArticleViewController
            let cell = sender as! CollectionViewCell
            articleView.articleText = cell.articleText
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allNews.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        guard let posterURL = URL(string: allNews[indexPath.item].urlToImageString) else {
            return cell
        }
        cell.sourceLabel.text = allNews[indexPath.item].sourceName
        cell.sourceLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        cell.articleLabel.text = allNews[indexPath.item].title
        cell.articleImage.sd_setImage(with: posterURL, completed: nil)
        cell.articleText = allNews[indexPath.item].description
        return cell
    }
    
}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = marginSize * (itemsPerRowAt + 1)
        let itemWidth: CGFloat = view.frame.width - paddingWidth
        let itemSize = CGSize(width: itemWidth, height: 0.7 * itemWidth)
        
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
