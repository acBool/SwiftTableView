//
//  TableHomeOnePicCell.swift
//  SwiftTableView
//
//  只有一张图片的cell

import UIKit

class TableHomeOnePicCell: TableHomeBaseCell {

    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = TableStyle.shared.mainBgColor()
        label.textColor = TableStyle.shared.homeListTextColor()
        label.font = TableStyle.shared.h4()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var picImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = TableStyle.shared.lineSpaceColor()
        return imageView
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
        self.contentView.addSubview(self.picImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin = RS(10)
        self.contentLabel.frame = CGRect(x: RS(70), y: RS(40), width: ScreenWidth - RS(80), height: self.cellFrame.contentHeight)
        self.picImageView.frame = CGRect(x: margin, y: self.contentLabel.frame.maxY + margin, width: self.cellFrame.onePicSize.width, height: self.cellFrame.onePicSize.height)
        let shapeLayer = cornerShapeLayer(view: self.picImageView, radius: RS(5))
        self.picImageView.layer.mask = shapeLayer
        spaceView.frame = CGRect(x: margin, y: self.cellFrame.height - 0.5, width: ScreenWidth - 2 * margin, height: 0.5)
    }
    
    override func bindData(_ model: TableHomeCircleModel,_ cellFrame: TableHomeListCellFrame) {
        super.bindData(model,cellFrame)
        self.contentLabel.text = model.content
        if model.imgArray.count > 0 {
            let picture: TablePicture = model.imgArray[0]
            if picture.imgUrl.count > 0 {
                self.picImageView.af.setImage(withURL: URL(string: picture.imgUrl)!)
            }
        }
        self.cellFrame = cellFrame
        setNeedsLayout()
    }
}
