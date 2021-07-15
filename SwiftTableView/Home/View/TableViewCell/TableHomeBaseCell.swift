//
//  TableHomeBaseCell.swift
//  SwiftTableView
//
//

import UIKit
import AlamofireImage

class TableHomeBaseCell: UITableViewCell {

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
        self.contentView.addSubview(headImageView)
        self.contentView.layer.addSublayer(nickNameLayer)
        self.contentView.addSubview(spaceView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin = RS(10)
        let headSize = RS(50)
        let leftX = headSize + 2 * margin
        headImageView.pin.top(margin).left(margin).width(headSize).height(headSize)
        let shapeLayer = cornerShapeLayer(view: headImageView, radius: headSize * 0.5)
        headImageView.layer.mask = shapeLayer
        
        let nickWidth = ScreenWidth - leftX - margin
        nickNameLayer.frame = CGRect(x: leftX, y: RS(15), width: nickWidth, height: RS(20))
        
        //spaceView.pin.left(margin).right(margin).height(0.5).bottom()
    }
    
    func bindData(_ model: TableHomeCircleModel, _ cellFrame: TableHomeListCellFrame) {
        self.nickNameLayer.string = model.nickName
        self.headImageView.image = UIImage(named: String(model.headImageIndex) + "_head")
    }
}
