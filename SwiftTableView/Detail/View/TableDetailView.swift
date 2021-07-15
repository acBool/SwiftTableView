//
//  TableDetailView.swift
//  SwiftTableView
//
//

import UIKit

class TableDetailView: UIView {
    
    var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout() {
        didSet {
            addCollectionView()
        }
    }
    
    var contentHeight: CGFloat = 0 {
        didSet {
            setupHeaderView()
        }
    }
    
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
        label.numberOfLines = 0
        return label
    }()
    
    lazy var collectionHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = TableStyle.shared.mainBgColor()
        collectionView.register(TableDetailCollectionCell.self, forCellWithReuseIdentifier: "TableDetailCollectionCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TableDetailView {
    func addCollectionView() {
        addSubview(collectionView)
        collectionView.pin.top(kTopHeight).left().right().bottom()
        print("234")
    }
    
    func setupHeaderView() {
        let leftX = kHomeHeadWH + 2 * kHomeMargin
        headImageView.frame = CGRect(x: kHomeMargin, y: kHomeMargin, width: kHomeHeadWH, height: kHomeHeadWH)
        let shapeLayer = cornerShapeLayer(view: headImageView, radius: kHomeHeadWH * 0.5)
        headImageView.layer.mask = shapeLayer
        let nickWidth = ScreenWidth - leftX - kHomeMargin
        nickNameLabel.frame = CGRect(x: leftX, y: RS(15), width: nickWidth, height: RS(20))
        contentLabel.frame = CGRect(x: kHomeContentX, y: kHomeContentY, width: ScreenWidth - kHomeContentX - kHomeMargin, height: self.contentHeight)
        
        let contentMaxY = kHomeContentY + contentHeight
        let headerHeight = (kHomePicBeginY > contentMaxY ? kHomePicBeginY : contentMaxY) + kHomeMargin
        collectionView.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        collectionHeaderView.frame = CGRect(x: 0, y: -headerHeight, width: ScreenWidth, height: headerHeight)
        collectionView.addSubview(collectionHeaderView)
        collectionView.setContentOffset(CGPoint(x: 0, y: -headerHeight), animated: false)
        collectionHeaderView.addSubview(headImageView)
        collectionHeaderView.addSubview(nickNameLabel)
        collectionHeaderView.addSubview(contentLabel)
    }
}

extension TableDetailView {
    func bindHeaderData(model: TableHomeCircleModel) {
        nickNameLabel.text = model.nickName
        headImageView.image = UIImage(named: String(model.headImageIndex) + "_head")
        contentLabel.text = model.content
    }
}
