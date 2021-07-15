//
//  TableHomeBaseCell.swift
//  SwiftTableView
//
//

import UIKit
import AlamofireImage

class TableHomeBaseCell: UITableViewCell {

    var picImageViewArray: [UIImageView] = []
    lazy var cellFrame: TableHomeListCellFrame = TableHomeListCellFrame()
    
    lazy var headImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = TableStyle.shared.mainBgColor()
        return imageView
    }()
    
    lazy var nickNameLayer: CATextLayer = {
        let layer = CATextLayer()
        layer.backgroundColor = TableStyle.shared.mainBgColor().cgColor
        layer.foregroundColor = TableStyle.shared.homeListTextColor().cgColor
        layer.alignmentMode = .left
        layer.fontSize = RFS(14.0)
        return layer
    }()
    
    lazy var spaceView: UIView = {
        let view = UIView()
        view.backgroundColor = TableStyle.shared.lineSpaceColor()
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(headImageView)
        self.contentView.layer.addSublayer(nickNameLayer)
        self.contentView.addSubview(spaceView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let leftX = kHomeHeadWH + 2 * kHomeMargin
        headImageView.pin.top(kHomeMargin).left(kHomeMargin).width(kHomeHeadWH).height(kHomeHeadWH)
        let shapeLayer = cornerShapeLayer(view: headImageView, radius: kHomeHeadWH * 0.5)
        headImageView.layer.mask = shapeLayer

        let nickWidth = ScreenWidth - leftX - kHomeMargin
        nickNameLayer.frame = CGRect(x: leftX, y: RS(15), width: nickWidth, height: RS(20))
    }
    
    func bindData(_ model: TableHomeCircleModel, _ cellFrame: TableHomeListCellFrame) {
        self.nickNameLayer.string = model.nickName
        self.headImageView.image = UIImage(named: String(model.headImageIndex) + "_head")
    }
}


extension TableHomeBaseCell {
    // 添加图片view
    func createSubImageViews(count: Int,hidden: Bool) {
        for _ in 1...count {
            let imageView = UIImageView()
            imageView.backgroundColor = TableStyle.shared.lineSpaceColor()
            imageView.isHidden = hidden
            self.contentView.addSubview(imageView)
            self.picImageViewArray.append(imageView)
        }
    }
    
    // colCount: 每列的个数
    func setupImageViewsFrame(maxY: CGFloat, colCount: Int) {
        let oneWidth = kHomeMargin + kHomePicWH
        let beginY = maxY + kHomeMargin
        // 设置每个imageView frame，不需要动态计算
        for i in 1...self.picImageViewArray.count {
            let imageView: UIImageView = self.picImageViewArray[i - 1]
            if !imageView.isHidden {
                imageView.frame = CGRect(x: kHomeMargin + CGFloat((i - 1) % colCount) * oneWidth, y: beginY + CGFloat(((i - 1) / colCount)) * oneWidth, width: kHomePicWH, height: kHomePicWH)
                let shapeLayer = cornerShapeLayer(view: imageView, radius: RS(5))
                imageView.layer.mask = shapeLayer
            }
        }
    }
    
    // 设置图片url
    func setupImagesUrl(model: TableHomeCircleModel) {
        let maxCount = model.imgArray.count > 9 ? 9 : model.imgArray.count
        for i in 1...maxCount {
            let picture: TablePicture = model.imgArray[i - 1]
            let imageView: UIImageView = self.picImageViewArray[i - 1]
            imageView.isHidden = false
            if picture.imgUrl.count > 0 {
                imageView.af.setImage(withURL: URL(string: picture.imgUrl)!)
            }
        }
        if model.imgArray.count < self.picImageViewArray.count {
            for i in (model.imgArray.count + 1)...self.picImageViewArray.count {
                let imageView: UIImageView = self.picImageViewArray[i - 1]
                imageView.isHidden = true
            }
        }
    }
}
