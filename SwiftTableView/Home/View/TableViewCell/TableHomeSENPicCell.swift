//
//  TableHomeSENPicCell.swift
//  SwiftTableView
//
//  7、8、9张图片cell

import UIKit

class TableHomeSENPicCell: TableHomeBaseCell {
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = TableStyle.shared.mainBgColor()
        label.textColor = TableStyle.shared.homeListTextColor()
        label.font = TableStyle.shared.h4()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var coverView: UILabel = {
        let view = UILabel()
        view.text = _L("more")
        view.textColor = TableStyle.shared.homeListTextColor()
        view.backgroundColor = TableStyle.shared.coverBordColor()
        view.textAlignment = .center
        view.isHidden = true
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.contentLabel)
        super.createSubImageViews(count: 9, hidden: true)
        self.contentView.addSubview(self.coverView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentLabel.frame = CGRect(x: kHomeContentX, y: kHomeContentY, width: ScreenWidth - kHomeContentX - kHomeMargin, height: self.cellFrame.contentHeight)
        super.setupImageViewsFrame(maxY: self.contentLabel.frame.maxY, colCount: 3)
        spaceView.frame = CGRect(x: kHomeMargin, y: self.cellFrame.height - 0.5, width: ScreenWidth - 2 * kHomeMargin, height: 0.5)
        
        if self.picImageViewArray.count == 9 {
            let imageView = self.picImageViewArray[8]
            coverView.frame = imageView.frame
        }
    }
    
    override func bindData(_ model: TableHomeCircleModel,_ cellFrame: TableHomeListCellFrame) {
        super.bindData(model,cellFrame)
        self.contentLabel.text = model.content
        self.cellFrame = cellFrame
        super.setupImagesUrl(model: model)
        if model.imgArray.count > 9 {
            coverView.isHidden = false
        }else {
            coverView.isHidden = true
        }
        setNeedsLayout()
    }

}
