//
//  TableDetailViewModel.swift
//  SwiftTableView
//
//

import Foundation
import UIKit

class TableDetailViewModel: NSObject {
    var model: TableHomeCircleModel = TableHomeCircleModel()
}


extension TableDetailViewModel: UICollectionViewDelegate {
    
}

extension TableDetailViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:TableDetailCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TableDetailCollectionCell", for: indexPath) as! TableDetailCollectionCell
        if indexPath.row < model.imgArray.count {
            let picture: TablePicture = model.imgArray[indexPath.row]
            cell.bindData(url: picture.imgUrl)
        }
        
        return cell
    }
}
