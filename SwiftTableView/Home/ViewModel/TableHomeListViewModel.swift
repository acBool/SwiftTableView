//
//  TableHomeListViewModel.swift
//  SwiftTableView
//
//

import Foundation
import UIKit


// 缓存布局信息
class TableHomeListCellFrame {
    var height: CGFloat = 0
    var contentHeight: CGFloat = 0
    var onePicSize: CGSize = CGSize(width: 0, height: 0)
    var contentFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
}


class TableHomeListViewModel: NSObject {
    var maxPicWH = (Int)(RS(300))
    var dataSourceArray: [TableHomeCircleModel] = []
    var cellFrameArray: [TableHomeListCellFrame] = []
    var typeDictInfo: [String: TableHomeCellType] = ["text": .TableHomeCellTypeWord,"img_1": .TableHomeCellTypeOnePic,"img_2": .TableHomeCellTypeTTPic,"img_3": .TableHomeCellTypeTTPic,"img_4": .TableHomeCellTypeFourPic,"img_5":.TableHomeCellTypeFSPic,"img_6":.TableHomeCellTypeFSPic,"img_7":.TableHomeCellTypeSENPic,"img_8":.TableHomeCellTypeSENPic,"img_9":.TableHomeCellTypeSENPic]
}

extension TableHomeListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 首先判断是否已经计算过高度了
        
        if indexPath.row < cellFrameArray.count {
            let cellFrame: TableHomeListCellFrame = cellFrameArray[indexPath.row]
            if cellFrame.height == 0 {
                // 说明高度需要计算
                let model: TableHomeCircleModel = dataSourceArray[indexPath.row]
                let typeStr = self.getCellType(model: model)
                let cellType = typeDictInfo[typeStr]
                if cellType == nil {
                    return kDefaultCellHeight
                }else{
                    switch cellType {
                    case .TableHomeCellTypeWord:
                        calculateCellHeight(cellFrame: cellFrame, numRows: 0, model: model)
                        return cellFrame.height
                    case .TableHomeCellTypeOnePic:
                        calculateCellOnePicHeight(cellFrame: cellFrame, model: model)
                        return cellFrame.height
                    case .TableHomeCellTypeTTPic:
                        calculateCellHeight(cellFrame: cellFrame, numRows: 1, model: model)
                        return cellFrame.height
                    case .TableHomeCellTypeFourPic:
                        calculateCellHeight(cellFrame: cellFrame, numRows: 2, model: model)
                        return cellFrame.height
                    case .TableHomeCellTypeFSPic:
                        calculateCellHeight(cellFrame: cellFrame, numRows: 2, model: model)
                        return cellFrame.height
                    case .TableHomeCellTypeSENPic:
                        calculateCellHeight(cellFrame: cellFrame, numRows: 3, model: model)
                        return cellFrame.height
                    default:
                        return kDefaultCellHeight
                    }
                }
            }else{
                // 直接返回已经存在的布局
                return cellFrame.height
            }
        }
        return kDefaultCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
    }
    
}

extension TableHomeListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < dataSourceArray.count {
            let model: TableHomeCircleModel = dataSourceArray[indexPath.row]
            var cell: TableHomeBaseCell
            var typeStr = model.type
            if model.type == "img"{
                typeStr = model.type + "_" + String(model.imgArray.count)
            }
            let cellType = typeDictInfo[typeStr]
            if cellType == nil {
                return TableHomeBaseCell()
            }
            cell = TableHomeCellFactory.createCellWithType(type: cellType!, tableView: tableView)
            cell.bindData(model,cellFrameArray[indexPath.row])
            return cell
        }
        return TableHomeBaseCell()
    }
}


extension TableHomeListViewModel {
    func getCellType(model: TableHomeCircleModel) ->String {
        var typeStr = model.type
        if model.type == "img"{
            typeStr = model.type + "_" + String(model.imgArray.count)
        }
        return typeStr
    }
}


// 计算高度相关
extension TableHomeListViewModel {
    
    // 计算只有一张图片cell的高度
    func calculateOnePicHeight(model: TableHomeCircleModel) ->(contentHeight:CGFloat, picSize:CGSize) {
        let contentHeight = self .calculateContentSize(content: model.content)
        if model.imgArray.count > 0 {
            let picture: TablePicture = model.imgArray[0]
            let picSize: CGSize = self.calculatePicSize(model: picture)
            return(contentHeight:contentHeight,picSize:picSize)
        }
        return(contentHeight: contentHeight, picSize:CGSize(width: 0, height: 0))
    }
    
    
    func calculateContentSize(content: String) -> CGFloat{
        let maxWidth = ScreenWidth - kHomeContentX - kHomeMargin
        let size = content.boundingRect(with: CGSize(width: maxWidth, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : TableStyle.shared.h4()], context: nil).size
        return size.height.ceil + RS(5)
    }
    
    func calculatePicSize(model: TablePicture) -> CGSize {
        
        let imgHeight = Int(RS(CGFloat(model.imgHeight)))
        let imgWidth = Int(RS(CGFloat(model.imgWidth)))
        if imgHeight > maxPicWH && imgWidth > maxPicWH{
            if imgHeight > imgWidth {
                // 高大于宽，以高为准
                return CGSize(width: maxPicWH * imgWidth / imgHeight, height: maxPicWH)
            }else{
                return CGSize(width: maxPicWH, height: imgHeight * maxPicWH / imgWidth)
            }
        }else if imgHeight > maxPicWH {
            // 高超过最大值，宽在最大值范围内
            return CGSize(width: maxPicWH * imgWidth / imgHeight, height: maxPicWH)
        }else if imgWidth > maxPicWH {
            // 宽超过最大值，高在最大值范围内
            return CGSize(width: maxPicWH, height: imgHeight * maxPicWH / imgWidth)
        }else {
            return CGSize(width: imgWidth, height: imgHeight)
        }
    }
    
    // 根据图片行数计算cell高度
    func calculateCellHeight(cellFrame:TableHomeListCellFrame, numRows: CGFloat, model: TableHomeCircleModel) {
        let contentHeight = self.calculateContentSize(content: model.content)
        cellFrame.contentHeight = contentHeight
        let contentMaxY = kHomeContentY + contentHeight
        cellFrame.height = (kHomePicBeginY > contentMaxY ? kHomePicBeginY : contentMaxY) + kHomeMargin * (numRows + 1.0) + kHomePicWH * numRows
    }
    
    // 计算含一张图片的cell的高度
    func calculateCellOnePicHeight(cellFrame: TableHomeListCellFrame, model: TableHomeCircleModel) {
        let value = self.calculateOnePicHeight(model: model)
        cellFrame.contentHeight = value.contentHeight
        cellFrame.onePicSize = value.picSize
        let contentMaxY = kHomeContentY + cellFrame.contentHeight
        cellFrame.height = (kHomePicBeginY > contentMaxY ? kHomePicBeginY : contentMaxY) + kHomeMargin * 2 + value.picSize.height
    }
}
