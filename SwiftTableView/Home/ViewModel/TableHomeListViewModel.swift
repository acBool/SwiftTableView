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
                let contentHeight = self .calculateContentSize(content: model.content)
                cellFrame.contentHeight = contentHeight
                cellFrame.height = RS(80) + contentHeight + RS(20)
                print("calculate height = \(cellFrame.height)")
                return cellFrame.height
            }else{
                print("no calculate height = \(cellFrame.height)")
                return cellFrame.height
            }
        }
        return RS(100)
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
    func calculateContentSize(content: String) -> CGFloat{
        let maxWidth = ScreenWidth - RS(80)
        return content.boundingRect(with: CGSize(width: maxWidth, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : TableStyle.shared.h4()], context: nil).size.height
    }
}
