//
//  TableDetailCollectionCell.swift
//  SwiftTableView
//
//

import UIKit
import AlamofireImage

class TableDetailCollectionCell: UICollectionViewCell {
    lazy var picImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = TableStyle.shared.lineSpaceColor()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableDetailCollectionCell {
    func setupUI() {
        addSubview(picImageView)
        picImageView.pin.top().left().right().bottom()
    }
    
    func bindData(url: String) {
        if url.count > 0 {
            picImageView.af.setImage(withURL: URL(string: url)!)
        }
    }
}
