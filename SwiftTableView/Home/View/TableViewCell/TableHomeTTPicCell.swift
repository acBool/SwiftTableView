//
//  TableHomeTTCell.swift
//  SwiftTableView
//
//  2张、3张图片的cell

import UIKit

class TableHomeTTPicCell: TableHomeBaseCell {

    var picImageViewArray: [UIImageView] = []
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = TableStyle.shared.mainBgColor()
        label.textColor = TableStyle.shared.homeListTextColor()
        label.font = TableStyle.shared.h4()
        label.numberOfLines = 0
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.contentLabel)
        
        for _ in 1...3 {
            let imageView = UIImageView()
            imageView.backgroundColor = TableStyle.shared.lineSpaceColor()
            imageView.isHidden = true
            self.contentView.addSubview(imageView)
            self.picImageViewArray.append(imageView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentLabel.frame = CGRect(x: kHomeContentX, y: kHomeContentY, width: ScreenWidth - kHomeContentX - kHomeMargin, height: self.cellFrame.contentHeight)
        let oneWidth = kHomeMargin + kHomePicWH
        // 设置每个imageView frame，不需要动态计算
        for i in 1...self.picImageViewArray.count {
            let imageView: UIImageView = self.picImageViewArray[i - 1]
            if !imageView.isHidden {
                imageView.frame = CGRect(x: kHomeMargin + CGFloat((i - 1)) * oneWidth, y: self.contentLabel.frame.maxY + kHomeMargin, width: kHomePicWH, height: kHomePicWH)
                let shapeLayer = cornerShapeLayer(view: imageView, radius: RS(5))
                imageView.layer.mask = shapeLayer
            }
        }
        spaceView.frame = CGRect(x: kHomeMargin, y: self.cellFrame.height - 0.5, width: ScreenWidth - 2 * kHomeMargin, height: 0.5)
    }
    
    override func bindData(_ model: TableHomeCircleModel,_ cellFrame: TableHomeListCellFrame) {
        super.bindData(model,cellFrame)
        self.contentLabel.text = model.content
        for i in 1...model.imgArray.count {
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
        self.cellFrame = cellFrame
        setNeedsLayout()
    }
}
