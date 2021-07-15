//
//  TableHomeWordCell.swift
//  SwiftTableView
//
//  仅仅只有文字的cell

import UIKit

class TableHomeWordCell: TableHomeBaseCell {

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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentLabel.frame = CGRect(x: kHomeContentX, y: kHomeContentY, width: ScreenWidth - kHomeContentX - kHomeMargin, height: self.cellFrame.contentHeight)
        spaceView.frame = CGRect(x: kHomeMargin, y: self.cellFrame.height - 0.5, width: ScreenWidth - 2 * kHomeMargin, height: 0.5)
    }
    
    override func bindData(_ model: TableHomeCircleModel,_ cellFrame: TableHomeListCellFrame) {
        super.bindData(model,cellFrame)
        self.contentLabel.text = model.content
        self.cellFrame = cellFrame
        setNeedsLayout()
    }
}

