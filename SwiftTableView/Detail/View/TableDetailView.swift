//
//  TableDetailView.swift
//  SwiftTableView
//
//

import UIKit

class TableDetailView: UIView {
    
    lazy var headImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = TableStyle.shared.mainBgColor()
        return imageView
    }()
    
    lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = TableStyle.shared.homeListTextColor()
        label.font = TableStyle.shared.h3()
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = TableStyle.shared.homeListTextColor()
        label.font = TableStyle.shared.h4()
        return label
    }()
    
    lazy var collectionHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TableDetailView {
    func setupUI() {
        collectionHeaderView.addSubview(headImageView)
        collectionHeaderView.addSubview(nickNameLabel)
        collectionHeaderView.addSubview(contentLabel)
    }
}
